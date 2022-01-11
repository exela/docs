# Linux Tips
====

This is a collection of the commands and items that might prove useful.

Remember, `apt` is designed for more of a user-friendly version of `apt-get`.


# OS Setup
-----

## Update & Maintain the Distro
This updates your ubuntu distro (keep up-to-date) sort of thing.

```
sudo apt-get update && sudo apt-get dist-upgrade
```

## Install Common Software Properties
The following command will install common software packages that will be used for other package installations in the future.

```
sudo apt-get install software-properties-common python-software-properties
```

## Installing .deb Files

Ubuntu by itself locks down .deb files.  We will use gdebi to install .deb files.

```
sudo apt-get install gdebi
```

So for example, if you downloaded an installer called `installFile.deb`, you would use gdebi with the following command:

```
sudo gdebi installFile.deb
```

## Install File Compression Libraries
We work with a bunch of different developers who all use different types of compression tools.  We should be able to open files if we install these packages.

```
sudo apt-get install unace unrar zip unzip xz-utils p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller
```

## Install Ubuntu Restricted Extras
This command allows you to install software which isn't normally included due to legal or copyright reasons.  Things such as the ability to play MP3's, Unencrypted DVD Playback, Microsoft TrueType Font installations etc.

```
sudo apt install ubuntu-restricted-extras
```


~~Skype Installation
----~~

Unless you really want to install Skype.

~~1. Navigate to where you can download. e.g., `cd ~/Downloads`~~

~~2. Download Skype: `wget https://go.skype.com/skypeforlinux64-deb`~~

~~3. Install Skype:  `sudo gdebi ./skypeforlinux64.deb`~~


# Java Installation
----

## Ensure OpenJDK is Uninstalled
```
dpkg -l | grep openjdk
dpkg -l | grep jre
```

If there is presence of OpenJDK, remove it:

```
sudo apt-get --purge remove openjdk*
sudo apt-get autoremove
```

## Download the proper JDK version you need

https://www.oracle.com/technetwork/java/javase/downloads/index.html

> **NOTE:** Be sure to download the `.tar.gz` file for your architecture 32 or 64-bit.

## Installing Java

We will be installing the JDK into `/usr/lib/jvm` since that is where it is usually installed to, by default.

1) Navigate to where the `.tar.gz` was downloaded.

```
cd Downloads
```

2) Move the `.tar.gz` to the `/usr/lib/jvm` directory.

```
sudo mv jdk-8u192-linux-x64.tar.gz /usr/lib/jvm
```

3) Extract the `.tar.gz`.

```
sudo tar xzvf jdk-8u192-linux-x64.tar.gz
```

4) Once java has been extracted, we will be setting up alternatives (since we are using mulitple JDK's):

```
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_192/bin/java 8
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_192/bin/javac 8
```

> **NOTE:** The number at the end of these commands denote the priority level given.  You can assign it any value you want.

> **NOTE:** You can also do this using the GUI for alternatives.  See below.


## Install a GUI for Alternatives (Easier Alternatives Switching)
```
sudo apt install galternatives
```

The GUI should now be installed as 'Alternatives' under Applications.  This application helps you swap between Java versions easily!

## Switching between Java Versions

### Command Line

You can select the Java Version your system will use using the command line alternatives:

```
sudo update-alternatives --config java
```


### GUI Alternatives

You can also use galternatives (the earlier application we installed).  When you open the program, find `java` in the left column and select from the available java versions.

## Setting up `JAVA_HOME`

These are the two methods that I use when swapping between my `JAVA_HOME` variables.  Method 2 is the main setup I have, but it's all up to you.

#### Method 1: Setting Up `JAVA_HOME` in User Profile Settings

1) Edit your user profile settings:

```
sudo nano ~/.bashrc
```

>**NOTE:** You can also use your favorite text editor.

2) Add the following lines, being sure to point `JAVA_HOME` to the correct Java version that you had set earlier when switching Java versions.

```
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_192
export PATH=$JAVA_HOME/bin:$PATH
```

3) Reload your user profile settings or open a new terminal.  Test using `echo` to confirm that the setting has taken.

```
source ~/.bashrc
echo $JAVA_HOME
```

### Method 2: Setting up `JAVA_HOME` using [JDK-Switch](https://github.com/exela/jdk-switch) and [jEnv](https://www.jenv.be/)

jdk-switch is a simple script that I had created in order to setup the `JAVA_HOME` variables (and `ANT_HOME` settings) quickly within the open terminal session that you are using.

Before we do that, we need to setup `jEnv` to help manage our installed JDKs.


#### Setting up [`jEnv`](https://www.jenv.be)
In order to use the scriipt, [jEnv](https://www.jenv.be) needs to be installed.

1) The following command will clone the repository to a `jenv` folder in your home directory.

```
git clone https://github.com/jenv/jenv.git ~/.jenv
```

2) The following commands will install `jEnv` into your `$PATH`.

If you use `bash` (default in Ubuntu):
```
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(jenv init -)"' >> ~/.bash_profile
```

If you use `zsh`:
```
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
```

3) Configure `jEnv` to add in the JDKs that we had previously installed earlier.

```
jenv add /usr/lib/jvm/java-6-oracle/
  oracle64-1.6.0.39 added
jenv add /usr/lib/jvm/java-7-oracle/
  oracle64-1.7.0.11 added
```

4) Now we can do several things with the manager, such as:

Listing managed JDKs:
```
$ jenv versions
  system
  oracle64-1.6.0.39
* oracle64-1.7.0.11 (set by /Users/.jenv/version)
```

Configure global version:
```
$ jenv global oracle64-1.6.0.39
```
Configure local version (per directory):
```
$ jenv local oracle64-1.6.0.39
Configure shell instance version
$ jenv shell oracle64-1.6.0.39
```

##### Setting up jdk-switch


1) Check out [JDK-Switch](https://github.com/exela/jdk-switch)!

2) Once installed, use the command `jdk #` to quickly setup the `JAVA_HOME` variable.  So for instance, if I want to set my `JAVA_HOME` to use JDK 1.8 - I would run the following command:

```
jdk 8
```

3) You will see that the change has occurred when you receive the following:

```
JAVA_HOME set to /usr/lib/jvm/jdk1.8.0_192
java version "1.8.0_192"
Java(TM) SE Runtime Environment (build 1.8.0_192-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.192-b12, mixed mode)
```

4) That's it!  You can set your `JAVA_HOME` variable through the use of this script or through your ~/.bashrc user profile.


# Installing Git and Repos
----

## Install Git & Other Necessary Tools
```
sudo apt update && sudo apt install git xclip
```

## Generate an SSH Key
```
ssh-keygen -t rsa -b 4096 -C "github@email.com"
```

>**NOTE:** The email used here should be the one that's used to login to your GitHub Account.

## Adding the SSH Key to Github
1. `eval "$(ssh-agent -s)"`
2. `ssh-add ~/.ssh/id_rsa`
3. `xclip -sel clip < ~/.ssh/id_rsa.pub`
4. Navigate to your github account > settings > add ssh or gpg keys
5. Add new SSH key.
6. Name it whatever you want.
7. Paste in the contents you had clipped in step 3.

## Clone the Repo
1) Navigate to where you want the repo.

> e.g. `cd ~/Liferay/repos`

2) We will now be cloning a copy of the repository into the directory we navigated to:

```
git clone git@github.com:projectName/branch.git
```

>**NOTE:** The path to the github project can be found on the project page, under the Clone or Download button.


# [DB Deployer](https://github.com/datacharmer/dbdeployer) Installation 
----

## Setup DB Deployer
1) Download the latest version of [DB Deployer](https://github.com/datacharmer/dbdeployer/releases)
2) Navigate to where the .tar.gz was downloaded and extract.

```
tar -xzf dbdeployer-VERSION.LINUX.tar.gz
```

3) Update the permissions for the newly extracted `dbdeployer-VERSION.LINUX` file

```
chmod +x dbdeployer-VERSION.LINUX
```

4) Move and rename (to dbdeployer) the program to a system-wide script area.

```
sudo mv dbdeployer-VERSION.LINUX /usr/local/bin/dbdeployer
```

## Setup Environment Variables
1) Edit the bash profile: `sudo nano ~/.bashrc`
2) Add in the Environment Variables:

**This is where the MySQL servers are installed into.**

```
export SANDBOX_HOME=/home/usernamehere/Liferay/MySQL/servers
```


**This is where the MySQL Installation (tar.gz) Files go.**

```
export SANDBOX_BINARY=/home/usernamehere/Liferay/MySQL/tarballs
```


## Unpacking a MySQL Server
1) Download the proper MySQL community server being used. **(TAR.GZ FORMAT)**
2) Extract the .tar.gz to the SANDBOX_BINARY

```
dbdeployer unpack mysql-5.7.23-linux.tar.gz
```

3) This should extract to where you have set your SANDBOX_BINARY.

## Creating a MySQL Server
Now that we have extracted the binaries for a MySQL Server.  We will be creating our sandbox.

Here's a quick breakdown of the command we will be using.

```
dbdeployer deploy single MySQL-TARBALL-FOLDERNAME --sandbox-directory VersionNumberHere -p PasswordHere
```

>*NOTE*: By default, sandbox will use the version number as its port.

So for example, if we were installing a MySQL 5.7.23, the command would look like this.

```
dbdeployer deploy single 5.7.23 --sandbox-directory 5723 -p liferay
```

This creates the following:
- A sandbox directory called `5723` where we defined `SANDBOX_HOME`
- A default password of `liferay`
- The user is `root` by default
- The port is `5723`


**NOTE**: IF you need a custom user name, you can set it up as follows.

```
dbdeployer deploy single MySQL-TARBALL-FOLDERNAME --sandbox-directory VersionNumberHere -u CustomUser -p PasswordHere
```

```
dbdeployer deploy single 5.7.23 --sandbox-directory 5723 -u lruser -p liferay
```

This creates the following:
- A sandbox directory called `5723` where we defined `SANDBOX_HOME`
- A user called `lruser`
- A default password of `liferay`
- The port is `5723`

## Setup UTF-8 Compatibility and Case Insensitivity
1) Edit the `my.sandbox.cnf` file in each of the MySQL servers.
2) Place the following properties under the `[mysqld]` section.

```
character-set-server=utf8
collation-server=utf8_general_ci
lower_case_table_names=1
```

**NOTE** Ignoring Case Sensitivity is useful, because some client imports do not adhere to case sensitivity.

## Using MySQL Sandbox
* `./start` in the server folder to start up the server.
* `./stop` to stop the server.
* `./my sql` calls up the MySQL prompt.
* `./my sqldump` to call the MySQL dump command.

**NOTE:** You call commands like mysqldump, etc. by just the use of something like `./my sqldump`

## ERROR: Access Denied

Sometimes, you might encounter an error when trying to login to your sandbox.

```
ERROR [main][DialectDetector:147] java.sql.SQLException: Access denied for user 'root'@'localhost' (using password: YES)
java.sql.SQLException: Access denied for user 'root'@'localhost' (using password: YES)
```

This can be a result of a bad restart/write to configs.  To fix this issue, we can do the following.

1) Verify the `my.sandbox.cnf` file in the sandbox has the proper user and passwords set.
2) Shut down the sandbox using `./stop`
3) Start up the sandbox, disabling the grant tables so that we can login without a password:

```
./start --skip-grant-tables
```

4) Login to the MySQL Prompt:

```
./my sql
```

5) Once logged in, we are going to reload grant tables so account-management statements work:

```
FLUSH PRIVILEGES;
```

6) Update the `'root'@'localhost'` account password.  Replace the password with the password you want to use.

```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass';
```


## Install MySQL Workbench
Workbench is a useful GUI tool to help manage MySQL/mariadb databases.

```
sudo apt install mysql-workbench
```





# MySQL Sandbox Installation (Outdated - Use DBDeployer Instead!)
----

MySQL Sandbox is no longer being maintained, but can still be used if you do not want to use dbdeployer.  The following is kept here for archival purposes.

## Setup MySQL Sandbox

```
sudo apt install mysql-sandbox libaio1 libaio-dev
```

## Setup MySQL Sandbox Variables

1) Edit the bash profile: `sudo nano ~/.bashrc`

2) Add in the Environment Variables:

(This is where the MySQL servers are installed into.)

* `export SANDBOX_HOME=/home/usernamehere/Liferay/MySQL/servers`

(This is where the MySQL Installation (tar.gz) Files go.)

* `export SANDBOX_BINARY=/home/usernamehere/Liferay/MySQL/tarballs`

## Setup MySQL Sandbox Defaults

`sudo nano /usr/share/perl5/MySQL/Sandbox.pm`

Edit the default_users section:

* `db_user = root`

* `db_password = password`

* `remote_access = %`

This allows all remote connections.

## Installing a MySQL Server

1. Download a `tar.gz` file of the MySQL Community Server that you want to install into the `tarballs` folder that you had previously defined.

2. Open terminal and use the following command:

```
make_sandbox /path/to/tarballs/mysql-X.X.XX-linux-x86_62.tar.gz -- --sandbox_directory #### -P #### -p password
```

This command will perform a few actions:
- extract `mysql-X.X.XX-linux-x86_62.tar.gz` to the `servers` folder
- extracted files will be placed into a directory `####` that was defined using `sandbox_directory`
- it will set the port to `####` set by `P` parameter
- it will set the root password of the installation to `password`

So for example, if you were to run the following command:
`make_sandbox /Users/liferay/tarballs/mysql-8.0.19-x86_64.tar.gz -- --sandbox_directory 8019 -P 8019 -p liferay`

It will exract MySQL 8.0.19 into a folder `8.0.19` in the `servers` folder that was defined for `SANDBOX_HOME`, setting the port to `8019` and the password to `liferay`.

3. If done correctly, the following prompt will appear.
```
unpacking /Users/sarahmarley/Documents/Liferay/tarballs/mysql-8.0.19-x86_64.tar.gz
Executing low_level_make_sandbox --basedir=/Users/liferay/tarballs/8.0.19 \
	--sandbox_directory=msb_8_0_19 \
	--install_version=8.0 \
	--sandbox_port=8019 \
	--no_ver_after_name \
	--sandbox_directory \
	8018 \
	-P \
	8018 \
	-p \
	liferay \
	--my_clause=log-error=msandbox.err
    The MySQL Sandbox,  version 3.2.17
    (C) 2006-2018 Giuseppe Maxia
Installing with the following parameters:
upper_directory                = /Users/liferay/servers
sandbox_directory              = 8019
sandbox_port                   = 8019
check_port                     = 
no_check_port                  = 
datadir_from                   = script
install_version                = 8.0
basedir                        = /Users/liferay/tarballs/8.0.19
tmpdir                         = 
my_file                        = 
operating_system_user          = liferay
db_user                        = msandbox
remote_access                  = 127.%
bind_address                   = 127.0.0.1
ro_user                        = msandbox_ro
rw_user                        = msandbox_rw
repl_user                      = rsandbox
db_password                    = liferay
repl_password                  = rsandbox
my_clause                      = log-error=msandbox.err ; default_authentication_plugin=mysql_native_password
init_options                   =  --default_authentication_plugin=mysql_native_password
init_my_cnf                    = 
init_use_cnf                   = 
master                         = 
slaveof                        = 
high_performance               = 
gtid                           = 
pre_start_exec                 = 
pre_grants_exec                = 
post_grants_exec               = 
pre_grants_sql                 = 
post_grants_sql                = 
pre_grants_file                = 
post_grants_file               = 
load_plugin                    = 
plugin_mysqlx                  = 
mysqlx_port                    = 
expose_dd_tables               = 
custom_mysqld                  = 
prompt_prefix                  = mysql
prompt_body                    =  [\h] {\u} (\d) > 
force                          = 
no_ver_after_name              = 1
verbose                        = 
load_grants                    = 1
no_load_grants                 = 
no_run                         = 
no_show                        = 
keep_uuid                      = 
keep_auth_plugin               = 
history_dir                    = 
do you agree? ([Y],n) Y
# Starting server
.. sandbox server started
# Loading grants
Your sandbox server was installed in $HOME/servers/8019
```

Simple right?

## Setup UTF-8 Compatibility

1) Edit the `my.sandbox.cnf` file in each of the MySQL servers.

2) Place the following properties under the `[mysqld]` section.

```
[mysqld]
character-set-server=utf8
collation-server=utf8_general_ci
```



# VMware Player
----
## Installing VMware Player
```
sudo apt update
wget https://download3.vmware.com/software/player/file/VMware-Player-14.1.1-7528167.x86_64.bundle
chmod a+x ./VMware-Player-14.1.1-7528167.x86_64.bundle
sudo ./VMware-Player-14.1.1-7528167.x86_64.bundle
```

# DBeaver
---
DBeaver is an open-source SQL Browser!  You'll probably need it.

Download: https://dbeaver.io/download/


# Setting Up Aliases, Functions, and Environment Variables
----
The `.bashrc` file is where you can set aliases, functions, and environment variables to be used within Linux.

## Editing the File
`sudo nano ~/.bashrc`

## Example Aliases
* `alias clr='clear'`
* `alias navd='cd ~'`
* `alias gm='git merge'`

## Example Functions
```
function() lrclean{
echo "Cleaning up Temp/Work..."
rm -rf ./osgi/state/*
echo "OSGi State Folder Cleared!"
wait
rm -rf ./temp/*
echo "Temp Folder Cleared!"
wait
rm -rf ./work/*
echo "Work Folder Cleared!"
echo "Temp/Work Folders Cleared!"
}
```

## Example Environment Variables
`export ANT_OPTS="-Xms256m -Xmx4g"`
`export JAVA_HOME="/path/to/java/home/jdk"`
