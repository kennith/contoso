source "vagrant" "app" {
    communicator = "ssh"
    source_path = "bento/ubuntu-20.04"
    provider = "virtualbox"
    box_name = "contoso-${var.GIT_SHA}"
    template = ".packer/templates/Vagrantfile"
}

source "amazon-ebs" "app" {
    region = "us-west-2"
    // @TODO
    source_ami = "ami-12345678"
    instance_type = "t2.micro"
    ssh_username = "ubuntu"
    ami_name = "packer-ami-hash"
}

build {
    name = "contoso"
    sources = [
        "source.vagrant.app",
        "source.amazon-ebs.app"
    ]

    provisioner "shell" {
        only = ["amazon-ebs.app"]
        inline = [
            "echo Only AWS"
        ]
    }

    provisioner "shell" {
        only = ["vagrant.app"]
        script = ".packer/scripts/app.sh"
    }

    # transfer app tar.gz from source to image
    provisioner "file" {
        source = "${var.GIT_SHA}.tar.gz"
        destination = "/tmp/${var.GIT_SHA}.tar.gz"
    }

    provisioner "shell" {
        inline = [
            "sudo rm -rf /var/www/",
            "sudo mkdir /var/www/",
            "sudo chown $(whoami):$(whoami) /var/www/",
            "tar xf /tmp/${var.GIT_SHA}.tar.gz --directory=/var/www"
        ]
    }

    provisioner "file" {
        source = ".packer/etc"
        destination = "/tmp"
    }

    provisioner "shell" {
        inline = [
            "sudo mv /tmp/etc/apache2/envvars /etc/apache2/envvars",
            "sudo mv /tmp/etc/apache2/ports.conf /etc/apache2/ports.conf",
            "sudo mv /tmp/etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf",
            "sudo echo APACHE_RUN_USER=$(whoami) >> /etc/apache2/envvars",
            "sudo echo APACHE_RUN_GROUP=$(whoami) >> /etc/apache2/envvars",
            "sudo a2dissite 000-default",
            "sudo a2ensite default-ssl",
            "sudo a2enmod rewrite",
            "sudo a2enmod ssl",
        ]
    }

}
