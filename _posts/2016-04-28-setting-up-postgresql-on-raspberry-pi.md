---
layout: post
title: "Setting up PostgreSQL on Raspberry Pi"
image: http://i.imgur.com/ARMkoJo.png
---

In this tutorial, we'll be configuring your Raspberry Pi to run an instance of a PostgreSQL database server.

PostgreSQL is one of the most popular open source options for a free database server, and integrates well with a wide variety of languages.  For more details on PostgreSQL, feel free to check out their [about page](http://www.postgresql.org/about/).

#### Step 1: Update and Install Packages

First, go ahead and update your Pi's packages:

`sudo apt-get update`

Once this is finished, you can run the following command to grab and install PostgreSQL:

`sudo apt-get install postgresql-9.4`

It may take a bit to complete, but once it's done, confirm the installation:

`which psql`

You should get a result like this:

```
pi@raspberrypi:~ $ which psql
/usr/bin/psql
```

You should now have a fully functional PostgreSQL database server on your Pi!  It's that easy!

In the next steps, we'll configure this server to allow access from external clients (i.e. other computers running a server manager, such as [pgAdmin](www.pgadmin.org)).

#### Step 2: Modify Configuration

By default, PostgreSQL is configured to only allow access to it's databases from the same machine.  This is fine for testing, but our aim is to have a centralized, locally accessible database server.  To open access for other machines, we'll need to modify a few  configuration files.

First, let's modify the `pg_hba.conf` file.  This controls client authentication and is, by default, configured to only allow local access.  Before we make any edits, however, we'll want to create a backup of our default configuration:

`sudo cp /etc/postgresql/9.4/main/pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf.bak`

Then, enter the following to open the file for editing:

`sudo nano /etc/postgresql/9.4/main/pg_hba.conf`

At the end of this file, enter the following line:

```
host     all     all     192.168.0.0/24     md5
```

This will allow access from users on our local network (i.e. any client with a 192.168.0.* IP address.

NOTE: You may need to change the first part (192.168) if your router assigns a different network address (like 129.144).

To save your changes to the `pg_hba.conf` file, enter `Ctrl+X`, `y`, and `Enter`.

Next, we'll need to modify the main `postgresql.conf` configuration file to allow access from IP addresses other than localhost.  But first, make a backup of this file before proceeding:

`sudo cp /etc/postgresql/9.4/main/postgresql.conf /etc/postgresql/9.4/main/postgresql.conf.bak`

And then:

`sudo nano /etc/postgresql/9.4/main/postgresql.conf`

And change the following line:

```
listen_addresses = 'localhost'
```

To:

```
listen_addresses = '*'
```

This will allow the PostgreSQL server to accept connections from any IP address.  In combination with the changes we made to the `pg_hba.conf` file, this should allow any clients on the local network access to the server, while still protecting from outside requests.  As explained on [StackOverflow](http://stackoverflow.com/questions/9764126/how-to-configure-postgresql-postgresql-conf-listen-addresses-for-multiple-ip-add):

> listen\_addresses controls which IPs the server will answer on, not which IPs the server will permit connections to authenticate from. It's entirely reasonable and normal to use listen\_addresses '*' so the server will accept incoming connections on any ip assigned to an interface on the postgresql server host, while using pg_hba.conf to control access at a finer grained level for which IPs the server will accept logins from for specific databases and users.

#### Step 3: pgAdmin Setup

Next, let's go ahead and install a free GUI database management tool, [pgAdmin](www.pgadmin.org), on our client machine (in this case, a laptop running Linux):

`sudo apt-get install pgadmin3`

While this is completing, we'll need to set a password for the default PostgreSQL user.  Enter the following into the Pi server:

`sudo -u postgres psql`

`\password postgres`

And enter your new password for the default user.  When finished, enter:

`\q`

To quit PostgreSQL.

Once the pgAdmin install is completed on the client, go ahead and open it up.  You'll be greeted with a blank interface.  Click the icon in the upper left corner to generate a new PostgreSQL server connection form, and enter the following:

* **Name:** (This can be whatever you'd like)
* **Host:** (IP address of your Pi running PostgreSQL)
* **Port:** 5432
* **Service:** (Can leave this blank)
* **Maintenance DB:** (Default db to connect to, can leave as 'postgres')
* **Username:** (Can leave as 'postgres')
* **Password:** (The password we changed above)

At this point, you should be able to successfully connect to your Raspberry Pi PostgreSQL database server!  If not, go back and double check your configuration settings, or feel free to post any issues/questions in the comments below.

