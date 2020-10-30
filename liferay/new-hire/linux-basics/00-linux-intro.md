# Linux Basics - Introduction
Hello and welcome.  This is a short introduction into the world of Linux.  Hopefully by the end of this walkthrough, you'll be able to confidently (or at least less confusedly) navigate and manipulate the filesystem within different types of Unix systems (GNU/Linux, Ubuntu, Mac OSX, etc.) Let's get started!

## About Linux
Linux is based on the Unix Operating System (OS).  Developed in the late 1960s/early 1970s with a focus on an operating system that's accessible and secure for multiple people.  It's a free, open-source operating system that's constantly evolving and developing.  

Typically, it's made up of 3 distinct parts:
- the kernel
- the shell
- the programs

We will be talking more about the Kernel and Shell since I assume we understand what programs are.

### Kernel
The kernel is the hub of the entire OS.  It's the one that allocates resources to programs, handles the filesystem/filestore, as well as all of the communications within the system.

### Shell/Terminal
The shell is the interface used between the user and the kernel.  Accessing the terminal shell allows users to execte commands - which are then translated by the kernel in order to perform an operation.  It's a command line interpreter (CLI) - which means it's interactive!  We specify commands to run and the shell is what outputs the results of those commands.  The commands we run are themselves, programs.

Nearly all tasks can be accomplished through the terminal.  Things like navigation, file manipulation, package installations, and user management.  Adept users can even customize their own shell - even using different shells on the same machine.  There are several different shell types:

- Bourne shell (sh)
- C-shell (csh)
- TC shell (tcsh)
- Korn shell (ksh)
- Bourne Again shell (bash)

Most shells these days have common features to help us when we input commands.

The following are two common features we can find:

**Filename Completion**:  When we type a part of the name of a command, filename, or directory and then pressing the `[TAB]` key - the shell will try to complete the rest of the name automatically.  If there is more than one name available for the letters that have been typed in, you may not get any results - in which case you should probably type a few more letters before pressing `[TAB]` again.

**History**: The Shell keeps a list of the commands we have previously typed in.  If for any reason we need to repeat a command, we can use the arrow keys [**up**] and [**down**] to scroll through the history of previous commands.

All Unix systems will have a terminal shell installed.  Just search for one through your installed applications!

### Programs

Programs are system commands that are run to perform a certain action.  Things such as `cd`, `rm`, `zip`, are all examples of different programs.

## Understanding the FileSystem

### Files and Processes
Things within the Operating System are either a file or process.

#### Processes
A process is an executing program identified by its unique process identifier known as a **PID**.  This is important because multiple processes of the same name can be running - but each can be uniquely identified.

#### Files
Files are a collection of data typically created through the use of text editors, compilers, or other programs.

Some examples of files (which you may already know):
- documents (report, article, etc.)
- PDFs
- executable or binary files
- text document that contains the secret launch codes to a weapons factory hidden away in Antarctica
- directory/directories which may be a mixture of other directories or files

### Directory Structure/Tree
Files are grouped within the directory structure/Tree.  This filesystem is typically arranged in a hierachy (think inverted tree).  It means we can create directories (or 'folders') inside other directories, with files existing in any one directory.

At the top of the hiearchy, this is usually called the `root` of the filesystem which is normally written as a slash **/**.

When we refer to the full path of specific file or location, it is usually given as **"/home/folder/containing/file.doc"**.  This is what is usually referred to as an absolute path.  Relative Paths also exist within Linux, but more information about that later.

## Next Steps

With this quick introduction complete, we will now be moving onto more hands-on activities with the Terminal - specifically, file navigation.
