# Mysql TroubleShooting

## Install

    brew install mysql

## Config

In `/usr/local/etc`, create `my.cnf` file which contains 

    [client]
    port = 3306
    socket = /tmp/mysql.sock
    default-character-set = utf8

    [mysqld]
    collation-server = utf8_unicode_ci
    character-set-server = utf8
    init-connect ='SET NAMES utf8'
    max_allowed_packet = 64M
    bind-address = 127.0.0.1
    port = 3306
    socket = /tmp/mysql.sock
    innodb_file_per_table=1

    [mysqld_safe]
    timezone = '+0:00'

then init database:

    unset TMPDIR

    mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)"
    --datadir=/usr/local/var/mysql --tmpdir=/tmp

## Start

    mysql.server start

## secure

After typing the following command, you will able to configure the security of

the database

    mysql_secure_installation




