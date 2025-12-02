---
layout: post
title: "dplyr and Oracle database with DatabaseConnector and JDBC on Windows"
date: 2025-12-02 09:05:50 +0100
author: Guillaume Pressiat
tags: R
comments: true
---



In a pretty old [post](https://guillaumepressiat.github.io/blog/2019/11/oraclyr) on this blog, I wrote about an Oracle database connection from R on Windows with ODBC when you have old Oracle clients (32 bit version) installed in an enterprise setup.

It's still working on R 32 bit. But now R new releases are only delivered in 64 bit version. Hard to stay with a R 4.1 (last 32bit) when we are now at R 4.5...

In such a situation, are there any alternatives?

<!--more-->

## An alternative with JDBC

**Java on the rescue?**

With JDBC clients and jar files, DBeaver is able to connect to all types of databases, so R should also be able to do so, both in 32b or 64b and on the most recent versions only with JDBC drivers?

Yes, it works too, see OHDSI's [DatabaseConnector](https://ohdsi.github.io/DatabaseConnector/articles/Connecting.html) package.


I am posting an example of use here.


{% highlight r %}
Sys.setenv("DATABASECONNECTOR_JAR_FOLDER" = "~/drivers_dbeaver/oracle")

library(DatabaseConnector)
library(dplyr)
library(dbplyr)

conn <- connect(
  createConnectionDetails(
    dbms="oracle", 
    connectionString = "jdbc:oracle:thin:@db-server.fr:1521/APPNAME",
    user = "resu",
    password = "drowssap"
  )
)

# SQL
querySql(conn,"SELECT COUNT(*) FROM appname.table_a")
# dplyr / dbplyr
tbl(conn, in_schema('APPNAME', 'TABLE_A')) %>% count()

disconnect(conn)
{% endhighlight %}


This package seems very interesting and is not limited to Windows and Oracle support, see here for more informations:
[https://github.com/OHDSI/DatabaseConnector/](https://github.com/OHDSI/DatabaseConnector/)

