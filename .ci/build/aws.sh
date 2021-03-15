if [ -f .ci/.env.sh ]; then
    source .ci/.env.sh
fi

APP=`git rev-parse HEAD`.tar.gz
git archive --format tar.gz -o $APP HEAD

$(which packer) build -only '*.amazon-ebs.*' .packer

rm $APP
