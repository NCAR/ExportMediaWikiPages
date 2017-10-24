# ExportMediaWikiPages

A simple script to export all mediawiki pages to local directory for viewing when web server is down. The script queries the mysql server hosting mediawiki directly to pull the pages. All page names are mangled to play nice on posix filesystem.

# Prerequisites
* Working mediawiki install
* Access to the mysql db of the wiki
  * Read only user with access only to the page table. (Don't expose your user credentials.)

# Example usage
* Call from console directly:
```bash
$ bash dump_wiki.sh 
dump_wiki.sh {dump path} {mediawiki db name}
```
* Setup cronjob to call regularly to update with any new changes:
```bash
root@$host:/# crontab -u $unpriv_user -l
0 */2 * * * ~/bin/dump_wiki.sh /shared/fs/wiki_example wikidbname 2>&1 | logger -t dump_wiki
```
