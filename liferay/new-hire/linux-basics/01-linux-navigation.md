# Linux Basics - Navigation

In our previous section, we briefly went over what makes up a Linux OS.  In this section, we will be exploring how we can navigate our directory structure as well as some important information about users and their shells.  Time to jump in!

## Starting a Terminal
Before we can even navigate our filesystem, we will first need to open a terminal.  You can do this by searching for the 'Terminal' in your Applications section of your OS.

For Ubuntu Users, you can just hit the 'Windows' or 'Command' key on your keyboard to bring up a search.  Just type in 'Terminal' and you should be able to find it.

### User Login
When opening the new terminal shell, you'll be greeted with a prompt within the CLI.  Depending on the shell, there are a few elements you might notice.  If you are in Ubuntu, you should see the following:

```bash
userName@local.machine:~$
```

Now this tells us a few things about this currently active/open terminal shell session.  

It tells us:
- what `user` is currently logged in (**userName**)
- as well as 'where' the user is performing any of the actions (**local.machine**)
- where in the filepath the session is currently (**~** - the 'home' directory)

By default, when the user (that you are logged in as) opens a terminal shell, that session is logged in with that user.  Remember earlier, we had mentioned that you can have multiple terminal sessions open for different users.  This line tells us the information about what the current session has and what kind of permissions are available (because it tells us what user is currently active within that session).

### A Special User - Root
Previously, we had mentioned that when opening a session, that specific session is logged in as the user that opened the terminal shell.  Most of the time, our regular user has the necessary permissions for a lot of the actions we will perform.  However, there are specific areas of the filesystem that are protected or require elevated permissions in order to access or write files to.  These areas usually involve system files or other high-level protected files to help ensure that programs within the operating system are not compromised.  There may be times in which we will need to access these specific areas and that is when the `root` user is required.

The biggest thing to remember about the `root` user is that **UNLESS NECESSARY - DO NOT LOG INTO AS `ROOT`**.

The `root` user is a special administrative account used within the OS.  It has near complete control over the system.  That also means that it has unlimited power to destroy the system.

When you log in as the `root` user, your terminal prompt will change from

```bash
userName@local.machine:~$
```

to something that looks like this

```bash
root@local.machine:~#
```

The **#** denotes that the `root` user is being used.

### Using `root` (changing identities)
Because `root` is a separate 
