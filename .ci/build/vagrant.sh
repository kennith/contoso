if [ -f .ci/.env.sh ]; then
    source .ci/.env.sh
fi

rm -rf output-app

APP=`git rev-parse HEAD`.tar.gz
git archive --format tar.gz -o $APP HEAD

$(which packer) build -only '*.vagrant.*' .packer

rm $APP
