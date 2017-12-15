# Replace root with username and drupal with database name
# Replace path with absolute path

mysqldump -u root -p drupal \
| grep -v '^INSERT INTO `cache\(_[_a-z]\+\)\?`' \
| grep -v '^INSERT INTO `search_index`' \
| grep -v '^INSERT INTO `menu_router`' > /path/dump.sql
