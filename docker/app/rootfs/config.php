<?php
/* redis */
$config["redis.host"] = getenv('REDIS_HOST');
$config["redis.port"] = getenv('REDIS_PORT');

/* app configs */
$config["app.url"] = getenv('APP_BASE_URL');

/* mysql database */
$config["db.host"] = getenv('MYSQL_HOST');
$config["db.port"] = getenv('MYSQL_PORT');
$config["db.dbname"] = getenv('MYSQL_DBNAME');
$config["db.user"] = getenv('MYSQL_USER');
$config["db.password"] = getenv('MYSQL_PASSWORD');

?>