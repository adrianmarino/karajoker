CREATE DATABASE IF NOT EXISTS karajoker_dev CHARACTER SET utf8;
CREATE DATABASE IF NOT EXISTS karajoker_test CHARACTER SET utf8;
CREATE DATABASE IF NOT EXISTS karajoker_prd CHARACTER SET utf8;

GRANT ALL ON `karajoker_dev`.* to 'karajoker'@'localhost' identified by '29042902';
GRANT ALL PRIVILEGES ON karajoker_test.* TO 'karajoker'@'localhost';
GRANT ALL PRIVILEGES ON karajoker_prd.* TO 'karajoker'@'localhost';