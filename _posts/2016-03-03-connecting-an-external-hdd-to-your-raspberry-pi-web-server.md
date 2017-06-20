---
layout: post
title: "Connecting an External HDD to Your Raspberry Pi Web Server"
image: http://i.imgur.com/XRljVy4.png
---

In the previous tutorial, [Setting Up a Raspberry Pi Web Server](http://blog.bpwalters.com/setting-up-a-raspberry-pi-web-server) , we followed the steps to set up your Rasbperry Pi as a web server, able to serve files publicly thanks to Dynamic DNS.

In this guide, I'll describe how to expand your Raspberry Pi's storage by connecting an external USB hard drive.  In addition, I'll go through the steps to configure the Samba file service on your server, so that you can transfer files directly from any other computers in your home.

Before we get started, you'll need to collect a few items we're going to use:

* A Raspberry Pi set up to run as a web server (see the tutorial [here](http://blog.bpwalters.com/setting-up-a-raspberry-pi-web-server) if you haven't done this yet)
* A USB hard drive (or if you have an extra 2.5" drive laying around, a SATA to USB enclosure)
* A powered USB hub (the powered part is key here) 

Now that we've got everything we need, let's get started!

#### Step 1: Connect Hub and Drive to the Pi

The first step is to connect up the powered USB hub.

Make sure you plug in the hub's power supply, as well as connect the hub's USB cable to one of your Pi's open USB ports.

NOTE: It's necessary to use a hub with a power supply for anything but a flash drive, since the on-board USB ports will not be able to supply enough power for an external hard drive.  If you try to connect a hard drive without using a powered hub, it may power up but not be detectable in the file system.

Next, let's connect your external drive to the hub.  At this point, if your drive is equipped with a power LED, it should light up indicating everything is connected correctly.

Now we can go ahead and configure the HDD to play nice with Raspbian.

#### Step 2: Format HDD to 'ext4' and Mount

The recommended file format for Linux drives is 'ext4'.  If your drive isn't already formatted to 'ext4', don't worry - it's easy enough to do from within the Pi's terminal.  First, make sure your newly connected drive is detected:

`sudo fdisk -l`

You should see a list of connected storage, including your new hard drive.  In most cases, your drive will be detected under either 'dev/sda1' or '/dev/sdb1'.  If you have multiple devices connected, you can narrow down to which is your hard drive by looking at the storage "Size" of the device (in my case, the device at 'sda1' reports 7.5G; the capacity of my drive):

!['fdisk -l' results, highlighting storage capacity of the attached drive](http://i.imgur.com/XRljVy4.png)

NOTE: If your drive is currently divided into multiple partitions, they will appear as separate entries here (i.e. 'sda1', 'sda2', etc.).

Now that we know where our drive is connected to, we can go ahead and format it to the Linux-friendly format of 'ext4'.  To do this, first need to wipe any formatted partitions:

`sudo wipefs -a /dev/sda`

Confirm that the drive is now unformatted by checking the `sudo fdisk -l` results:

!['fdisk -l' to confirm drive was wiped](http://i.imgur.com/IGU1Fer.png)

Next, we need to create a new partition on the drive.  To do this, we'll use the 'fdisk' utility:

`sudo fdisk /dev/sda`

Type `n` to define a new partition on the drive.  In the prompts that follow, you can just hit "Enter" to choose the default values and create your new partition.  Once the process is complete, you should see the message "Created a new partition 1 of type 'Linux' and a size of xxx.x GiB." (NOTE: The size listed here will depend on the capacity of your drive).

Finally, save your changes and exit by typing `w`.  

Now that the drive is set up with a single, new partition, we can format it to 'ext4':

`sudo mkfs.ext4 /dev/sda1`

NOTE: Formatting will erase all data currently on the drive.  If there are currently files you plan to use on the drive, I highly recommend disconnecting the drive now and backing them on another computer.

The format process may take a while, but once it's done, run `sudo fdisk -l` again to make sure your drive was correctly formatted (your drive entry should have a "System" type of "Linux" now):

![The newly formatted drive with an 'ext4' file system](http://i.imgur.com/plo00Y5.png)

Finally, let's create a mount point for our newly formatted drive in our Raspbian system.  This will allow us to more easily reference the storage location from our web server or through any connections we might make:

`sudo mkdir -m 755 /mnt/usb`

This creates a mount point titled "usb" for our drive.  Next, let's go ahead and mount the drive to the newly created mount point:

`sudo mount /dev/sda1 /mnt/usb`

To save some time in the future and auto-mount the drive to this point at startup, run the following:

`sudo nano /etc/fstab`

Next enter the following line after the last entry in the configuration file:

`/dev/sdb1  /mnt/usb  ext4  defaults  0  0`

Save and confirm your changes by typing 'Ctrl+X', 'y', and finally 'Enter'.

Now that our drive is formatted, and set to auto-mount at startup, we can install Samba to manage our files remotely.

#### Step 3: Installing and Configuring Samba

Before installing Samba, let's make sure your packages are up-to-date:

`sudo apt-get update`

`sudo apt-get upgrade`

Then install Samba:

`sudo apt-get install samba samba-common-bin`

Once the installation is complete, we'll first make a backup of our Samba configuration file as we're going to be making some changes to it in a second:

`sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.old`

Next, open the Samba configuration file for editing:

`sudo nano /etc/samba/smb.conf`

First, add `security=user` under the "Authentication" section.  Once that's done, we'll need to notify Samba of our new drive, and map it to the "usb" share.  To do this, enter the following just before the end of the file:

```
[usb]
path=/mnt/usb
available=yes
valid users=smbuser
read only=no
browseable=yes
public=yes
writable=yes
```

Save your changes and exit the editor ('Ctrl+X', 'y', and finally 'Enter').  Finally, restart Samba:

`sudo service smbd restart`

You may have noticed in our configuration edits from earlier, we referenced a user "smbuser".  Let's go ahead and create that user:

`sudo useradd smbuser -m -G users`

`sudo passwd smbuser`

And set their password to access Samba:

`sudo smbpasswd -a smbuser`

Before moving on, let's quick recap what we've accomplished so far:

* Connected powered USB hub to our Raspberry Pi
* Connected our external drive to the USB hub
* Formatted our external drive to 'ext4'
* Configured our external drive to auto-mount to the Raspbian file system
* Installed and configured Samba to recognize our new drive
* Created 'smbuser' to access our new Samba share

#### Step 4: Create a Symbolic Link

It's super easy to serve the files you have stored on your USB drive through your Apache server using a symbolic link.  Simply enter the following:

`sudo ln -s /mnt/usb /var/www/html/usb`

And that's it!  Your USB drive's files should now be accessible via your server's "/usb" directory (ex. http://123.456.7.890/usb).

#### Step 5: Connect to your Samba Share in Windows/Linux

To access your new file share via Windows/Linux, you'll first want to grant your new Samba user permission to read/write files in the USB drive:

```
sudo chown -R smbuser /mnt/usb
sudo chmod -R u+rw /mnt/usb
```



For Windows, open the File Explorer, right click on "My Computer" and select "Map Network Drive".  In the window that opens, enter the following information:

* Folder: \\\123.456.7.890\usb (replace with your Pi's IP address)
* Check "Connect using different credentials"
* Click "Finish"
* Click "Use another account"
* Username: pi\smbuser
* Password: smbuserPassword

In Linux, open the file manager and click "Connect to a server" under "Network".  Next, in the window that opens, enter the following information:

* Server Address: smb://123.456.7.890/usb (replace with your Pi's IP address)
* Username: smbuser
* Domain: pi
* Password: smbuserPassword

Alternatively, you can use a secure FTP client like [Filezilla](https://filezilla-project.org/) to access your Samba share:

* Host: 123.456.7.890 (replace with your Pi's IP address)
* Username: smbuser
* Password: smbuserPassword
* Port: 22

NOTE: To install Filezilla on Linux, simply run:

`sudo apt-get install filezilla`

And that's it!  Congratulations!  You're all set to serve content from your USB hard drive on your Raspberry Pi web server.

If you have any questions, comments, or suggestions, please feel free to leave a comment below!
