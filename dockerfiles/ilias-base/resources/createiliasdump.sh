#!/bin/bash
# How to read shell params: http://stackoverflow.com/a/14203146

HOST=mysql
PORT=3306
DATABASE=ilias
USER=root
PASSWORD=my-secret-pw
WWWDATA="/var/www/html/ilias/data"
DATA="/opt/iliasdata"
TARGETZIP="/data/share/ilias.tar.gz"

DUMP="/data/resources/iliasdump"
mkdir -p "$DUMP"
rm -r "$DUMP"
mkdir -p "$DUMP"
cp -r "$WWWDATA" "$DUMP/wwwdata"
cp "/var/www/html/ilias/ilias.ini.php" "$DUMP/ilias.ini.php"
cp -r "$DATA" "$DUMP/data"
mysqldump --host $HOST --user="$USER" --password="$PASSWORD" --port=$PORT --databases $DATABASE --add-drop-database > "$DUMP/ilias.sql"

#zip -r "$TARGETZIP" "$DUMP"
cd $DUMP
cd ..
tar -czf "$TARGETZIP" iliasdump/
rm -r "$DUMP"