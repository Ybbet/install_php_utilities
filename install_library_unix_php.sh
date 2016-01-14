#!/bin/bash
clear
if [[ -z "$TOOLS" ]]; then
    export TOOLS=$HOME/outils
fi
if [[ ! -d ${TOOLS} ]]; then
    mkdir -p ${TOOLS}
    chmod -R 0777 ${TOOLS}
fi
if [[ $(echo $PATH) == *"$TOOLS"* ]]; then
        echo $PATH
    else
        echo "Ajout de ${TOOLS} dans le PATH"
        export PATH=$PATH:$TOOLS
fi
cd ${TOOLS}
php=$(compgen -ac | grep '^php$')
if [[ $php ]]
    then
        echo "### La commande 'php' est disponible"
        php --version
        echo "### 'php' est dans le répertoire :"
        which php
    else
        echo "### La commande 'php' n'est pas disponible"
fi
echo
composer=$(composer --version)
if [[ $composer =~ ^Composer* ]];
    then
        echo "### Composer.phar est bien installé dans le répertoire :"
        which composer
        echo $composer
        echo "### On met à jour la version de composer.phar."
        sudo composer self-update
    else
        echo "### Composer.phar n'est pas bien installé. On lance son installation :"
        curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=${TOOLS} --filename=composer
        chmod a+x composer
        sudo mv composer ${TOOLS}/composer
        echo "### Composer.phar a bien été installé."
        which composer
        if [[ $(echo $PATH) == *"/.composer/vendor/bin"* ]];
            then
                echo ""
            else
                export PATH=$PATH:$TOOLS/.composer/vendor/bin
        fi
fi
echo
phpcs=$(phpcs --version)
if [[ $phpcs =~ ^PHP_CodeSniffer* ]];
    then
        echo "### PHP_CodeSniffer est bien installé dans le répertoire :"
        which phpcs
        echo $phpcs
        sudo composer update squizlabs/php_codesniffer
        echo "### Il a été mis à jour grâce à composer."
    else
        echo "### 'phpcs' n'est pas bien installé. On lance son installation avec composer :"
        sudo composer require squizlabs/php_codesniffer
        sudo composer install squizlabs/php_codesniffer
fi
echo
phpmd=$(phpmd --version)
if [[ $phpmd =~ ^PHPMD* ]];
    then
        echo "### PHPMD est bien installé dans le répertoire :"
        which phpmd
        echo $phpmd
        echo "### Il a été mis à jour grâce à composer."
        sudo composer update pdepend/pdepend
        sudo composer update phpmd/phpmd
    else
        echo "### 'PHPMD' n'est pas bien installé. On lance son installation avec composer :"
        sudo composer require pdepend/pdepend
        sudo composer install pdepend/pdepend
        sudo composer require phpmd/phpmd
        sudo composer install phpmd/phpmd
        echo "### 'phpmd' a bien été installé."
        which phpmd
        echo "### 'pdepend' a bien été installé."
        which pdepend
fi
echo
phpcsfixer=$(compgen -ac | grep '^php-cs-fixer$')
if [[ $phpcsfixer ]]
    then
        echo "### La commande 'php-cs-fixer' est disponible."
        php-cs-fixer --version
        echo "### On met à jour la version de 'php-cs-fixer'."
        sudo composer update fabpot/php-cs-fixer
        echo "### 'php-cs-fixer' a été mis à jour dans le répertoire :"
        which php-cs-fixer
    else
        echo "### La commande 'php-cs-fixer' n'est pas disponible. On lance l'installation"
        composer require fabpot/php-cs-fixer
        sudo composer install fabpot/php-cs-fixer
        echo "### 'php-cs-fixer' a été installé dans le répertoire :"
        which php-cs-fixer
fi
echo
phpunit=$(phpunit --version)
if [[ $phpunit =~ ^PHPUnit* ]];
    then
        echo "### 'PHPUnit' est bien installé dans le répertoire :"
        which phpunit
        echo $phpunit
        echo "### On met à jour 'PHPUnit'"
        sudo composer update phpunit/phpunit
    else
        echo "### 'PHPUnit' n'est pas bien installé. On lance son installation en téléchargeant le composer :"
        sudo composer require phpunit/phpunit
        sudo composer install phpunit/phpunit
        echo "### 'PHPUnit' a été installé dans le répertoire :"
        which phpunit
        if [[ $(which phpunit) ]];
            then
                echo "### 'PHPUnit' a bien été installé."
                which phpunit
            else
                echo "### Il y a eu un soucis à l'installation de 'PHPUnit'."
        fi
fi
echo
phpdoc=$(phpdoc --version)
if [[ $phpdoc =~ ^phpDocumentor* ]];
    then
        echo "### 'phpDocumentor' est bien installé dans le répertoire :"
        which phpdoc
        echo $phpdoc
        sudo composer update phpdocumentor/phpdocumentor
        echo "### Il a été mis à jour avec composer."
    else
        echo "### 'phpDocumentor' n'est pas bien installé. On lance son installation par composer :"
        sudo composer require "phpdocumentor/phpdocumentor:2.*"
        sudo composer install phpdocumentor/phpdocumentor
        echo "### 'phpDocumentor' a bien été installé."
        which phpdoc
fi
echo
nodejs=$(node --version)
if [[ $nodejs =~ ^v* ]];
    then
        echo "### 'Node JS' est bien installé dans le répertoire :"
        which node
        echo $nodejs
        sudo composer update mouf/nodejs-installer
        echo "### Il a été mis à jour avec composer."
    else
        echo "### 'Node JS' n'est pas bien installé. On lance son installation par composer :"
        sudo composer require "mouf/nodejs-installer:1.*"
        sudo composer install mouf/nodejs-installer
        echo "### 'Node JS' a bien été installé."
        which node
fi
echo
echo "### Node JS étant installé, nous allons installé Grunt et ses plugins"
sudo npm install -g grunt-cli
echo "### Installation du plugin Grunt-SASS"
sudo npm install grunt-contrib-sass --save-dev
echo "### Installation du plugin JShint pour Grunt"
sudo npm install grunt-contrib-jshint --save-dev
echo "### Installation du plugin UglifyJS pour Grunt"
sudo npm install grunt-contrib-uglify --save-dev
echo "### Installation du plugin Pleeease pour Grunt"
sudo npm install grunt-pleeease --save-dev
echo "### Installation du plugin HTML-Validation pour Grunt"
sudo npm install grunt-html-validation --save-dev
echo "### Installation du plugin Minify HTML pour Grunt"
sudo npm install grunt-contrib-htmlmin --save-dev
echo "### Installation du plugin Minify CSS pour Grunt"
sudo npm install grunt-contrib-cssmin --save-dev
echo "### Installation du plugin Watcher pour Grunt"
sudo npm install grunt-contrib-watch --save-dev
echo "### Installation du plugin Tasks pour Grunt"
sudo npm install --save-dev load-grunt-tasks
echo "### Installation du plugin Tasks pour Grunt"
sudo npm install gulp
phpcpd=$(phpcpd --version)
if [[ $phpcpd =~ ^phpcpd* ]];
    then
        echo "### 'PHPCPD' est bien installé dans le répertoire :"
        which phpcpd
        echo $phpcpd
        sudo composer update sebastian/phpcpd
        echo "### Il a été mis à jour avec composer."
    else
        echo "### 'PHPCPD' n'est pas bien installé. On lance son installation par composer :"
        sudo composer require "sebastian/phpcpd:*"
        sudo composer install sebastian/phpcpd
        echo "### 'PHPCPD' a bien été installé."
        which phpcpd
fi
echo
phpdcd=$(phpdcd --version)
if [[ $phpdcd =~ ^phpdcd* ]];
    then
        echo "### 'phpdcd' (Dead Code Detector for PHP code) est bien installé dans le répertoire :"
        which phpdcd
        echo $phpdcd
        sudo composer update sebastian/phpdcd
        echo "### Il a été mis à jour avec composer."
    else
        echo "### 'phpdcd' (Dead Code Detector for PHP code) n'est pas bien installé. On lance son installation par composer :"
        sudo composer require "sebastian/phpdcd:*"
        sudo composer install sebastian/phpdcd
        echo "### 'phpdcd' a bien été installé."
        which phpdcd
fi
echo
phploc=$(phploc --version)
if [[ $phploc =~ ^phploc* ]];
    then
        echo "### 'phploc' est bien installé dans le répertoire :"
        which phploc
        echo $phploc
        sudo composer update phploc/phploc
        echo "### Il a été mis à jour avec composer."
    else
        echo "### 'phploc' n'est pas bien installé. On lance son installation par composer :"
        sudo composer require "phploc/phploc:*"
        sudo composer install phploc/phploc
        echo "### 'phploc' a bien été installé."
        which phploc
fi
echo
phploc=$(phploc --version)
if [[ $phploc =~ ^phploc* ]];
    then
        echo "### 'phploc' est bien installé dans le répertoire :"
        which phploc
        echo $phploc
        sudo composer update phploc/phploc
        echo "### Il a été mis à jour avec composer."
    else
        echo "### 'phploc' n'est pas bien installé. On lance son installation par composer :"
        sudo composer require "phploc/phploc:*"
        sudo composer install phploc/phploc
        echo "### 'phploc' a bien été installé."
        which phploc
fi
echo
ruby_ok=$(ruby --version)
if [[ $ruby_ok =~ ^ruby* ]];
    then
        echo "### 'Ruby' est bien installé dans le répertoire :"
        which ruby_ok
        echo $ruby_ok
        echo "### Mise à jour de l'environnement de Ruby"
        sudo gem update --system
        echo "### On installe SASS"
        sudo gem install sass
        echo "### On installe Compass"
        sudo gem install compass
        echo "### Maintenant, nous allons installer des plugins pour Compass"
    else
        echo "### 'Ruby' n'est pas bien installé."
fi
# echo
# On ne va pas installer behat pour la machine. On l'installera à chaque projet.
# behat=$(behat --version)
# if [[ $behat =~ ^behat* ]];
#     then
#         echo "### behat est bien installé dans le répertoire :"
#         which behat
#         echo $behat
#         echo "### On met à jour la version de behat."
#         behat self-update
#     else
#         echo "### behat n'est pas bien installé. On lance son installation :"
#         curl -sS https://getbehat.org/installer | php -- --filename=behat
#         chmod a+x behat
#         sudo mv behat ${TOOLS}/behat
#         echo "### behat.phar a bien été installé."
#         which behat
# fi