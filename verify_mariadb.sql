mysql -u root -p

SHOW DATABASES;
USE test;
CREATE TABLE test_table( col1 INT(11), col2 VARCHAR(10));
INSERT INTO test_table VALUES (11, 'val1');
INSERT INTO test_table VALUES (22, 'val2');
SELECT * FROM test_table;
CREATE USER IF NOT EXISTS 'testuser'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON test.test_table TO 'testuser'@'localhost';



[myuser@localhost ~]$ mysql -u root -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 8
Server version: 10.3.11-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| test               |
+--------------------+
4 rows in set (0.051 sec)

MariaDB [(none)]> use test;
Database changed
MariaDB [test]> show tables;
Empty set (0.000 sec)

MariaDB [test]> CREATE TABLE test_table(
    -> col1 INT(11),
    -> col2 VARCHAR(10));
Query OK, 0 rows affected (0.196 sec)

MariaDB [test]> 
MariaDB [test]> INSERT INTO test_table VALUES (11, 'val1');
Query OK, 1 row affected (0.124 sec)

MariaDB [test]> INSERT INTO test_table VALUES (22, 'val2');
Query OK, 1 row affected (0.036 sec)

MariaDB [test]> SELECT * FROM test.test_table;
+------+------+
| col1 | col2 |
+------+------+
|   11 | val1 |
|   22 | val2 |
+------+------+
2 rows in set (0.000 sec)

MariaDB [test]> CREATE USER IF NOT EXISTS 'testuser'@'localhost' IDENTIFIED BY 'extemporal';
Query OK, 0 rows affected (0.000 sec)

MariaDB [test]> GRANT SELECT ON test.test_table TO 'testuser'@'localhost';
Query OK, 0 rows affected (0.000 sec)

MariaDB [test]> quit
Bye
[myuser@localhost ~]$ 


[root@localhost ~]# vi /usr/share/nginx/html/mariadb.php
[root@localhost ~]# cat /usr/share/nginx/html/mariadb.php[root@localhost ~]# elinks http://localhost/mariadb.php

<?php
$host='localhost';
$username='testuser';
$password='extemporal';
$database = 'test';
$connect = mysqli_connect($host, $username, $password, $database) or die("Failed to connect to mariadb: " . mysqli_error()); 
$result = $connect->query("select * FROM test.test_table");
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "col1: " . $row["col1"]. " col2: ". $row["col2"]. "<br/>";
    }
}
$connect->close();
?>
[root@localhost ~]# elinks http://localhost/mariadb.php

                                                                           http://localhost/mariadb.php 
   col1: 11 col2: val1                                                                                  
   col1: 22 col2: val2 

[root@localhost ~]#
