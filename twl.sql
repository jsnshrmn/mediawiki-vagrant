SET GLOBAL innodb_file_format = 'BARRACUDA';
SET GLOBAL innodb_default_row_format = 'DYNAMIC';
SET GLOBAL innodb_large_prefix = ON;

DROP DATABASE IF EXISTS centralauth;
CREATE DATABASE centralauth;
GRANT ALL PRIVILEGES ON wiki.* TO 'wikiadmin'@'localhost' IDENTIFIED BY 'wikipassword';
GRANT ALL PRIVILEGES ON centralauth.* TO 'wikiadmin'@'localhost' IDENTIFIED BY 'wikipassword';
FLUSH PRIVILEGES;
