#!/bin/bash
# How to read shell params: http://stackoverflow.com/a/14203146

HOST=mysql
PORT=3306
DATABASE=ilias
USER=root
PASSWORD=my-secret-pw
WWWDATA="/var/www/html/ilias/data"
DATA="/opt/iliasdata"
SRC="/data/share/ilias.tar.gz"

DUMP="/data/resources/iliasrestore/"
mkdir -p "$DUMP"
rm -r "$DUMP"
mkdir -p "$DUMP"

#unzip "$SRC" -d "$DUMP"
tar xzvf "$SRC" -C "$DUMP"
cp -a -r "/data/resources/iliasrestore/iliasdump/wwwdata/." $WWWDATA
cp -a -r "/data/resources/iliasrestore/iliasdump/data/." $DATA
cp -a "/data/resources/iliasrestore/iliasdump/ilias.ini.php" "/var/www/html/ilias/ilias.ini.php"

mysql -u "$USER" --password="$PASSWORD" --host=$HOST --port=$PORT < "/data/resources/iliasrestore/iliasdump/ilias.sql"

rm -r "$DUMP"

chown -R www-data:www-data "$WWWDATA"
chown -R www-data:www-data "$DATA"
chmod -R 775 "$WWWDATA"
chmod -R 775 "$DATA"
chown www-data:www-data /var/www/html/ilias/ilias.ini.php
chmod 666 /var/www/html/ilias/ilias.ini.php