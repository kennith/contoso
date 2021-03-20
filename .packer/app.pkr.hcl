source "vagrant" "app" {
    communicator = "ssh"
    source_path = "bento/ubuntu-20.04"
    provider = "virtualbox"
    box_name = "contoso-${var.GIT_SHA}"
    template = ".packer/templates/Vagrantfile"
}

source "amazon-ebs" "app" {
    region = "us-west-2"
    source_ami = "ami-0ca5c3bd5a268e7db"
    instance_type = "t2.small"
    ssh_username = "ubuntu"
    ami_name = "contoso-${var.GIT_SHA}"
    run_tags = {
        "Name": "contoso-${var.GIT_SHA}"
    }
    run_volume_tags = {
        "Name": "contoso-${var.GIT_SHA}"
    }
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
        pause_before = "15s"
    }

    provisioner "shell" {
        script = ".packer/scripts/app.sh"
    }

    provisioner "shell" {
        script = ".packer/scripts/install-composer.sh"
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
            "tar xf /tmp/${var.GIT_SHA}.tar.gz --directory=/var/www",
        ]
    }

    // Setup Laravel application
    provisioner "shell" {
        inline = [
            "cd /var/www && composer install --no-dev --no-suggest --no-progress -q",
            "echo APP_NAME=${var.APP_NAME} >> /var/www/.env",
            "echo APP_KEY=$(php /var/www/artisan key:generate --show) >> /var/www/.env",
        ]
    }

}
