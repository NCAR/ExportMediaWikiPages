#!/bin/bash
[ "$(id -u)" -eq 0 ] && echo "do not run this as root!" >&2 && exit 1
[ -z "$1" -o -z "$2" ] && echo "$0 {dump path} {mediawiki db name}" >&2 && exit 1

DUMP_PATH="$1"
WIKI_DB="$2"

function sql()
{
    #setup your my.cnf for user/password
    mysql -o $WIKI_DB
}

rm -f /$DUMP_PATH/*

umask 027 #only allow group to read

echo "select page.page_title from page WHERE page.page_namespace=0" | sql | while read page
do  
    f=$(echo "$page" | sed 's/\//\\/g' )
    echo "select text.old_text from page INNER JOIN text INNER JOIN revision ON revision.rev_id=page.page_latest && text.old_id=rev_text_id && page.page_namespace=0 && page.page_title=\"$page\"" | sql | sed 's/\\n/\n/g' |sed 's/old_text//g' > "/$DUMP_PATH/$f"
done

