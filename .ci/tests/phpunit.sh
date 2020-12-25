# install dependency
composer install -q --no-ansi --no-interaction --no-scripts --no-progress --prefer-dist

# run test
composer test
