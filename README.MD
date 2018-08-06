# Linux Command Line Lunch and Learn

# Table of Contents

## Objectives

We are going to attempt to cover the following commands.  The examples provided are not exhaustive of what each command can do.

Command | Description
------- | -----------
ls | Directory listing
mkdir | Make a directory
rmdir | Remove a directory
rm | Remove a file
cp | Copy a file
mv | Rename a file
cat | Print file contents to screen
wc | Word count
grep | Search files matching a pattern
sed | Editor and text transformer
awk | Pattern matching and text processing language
sort | Sort a file
uniq | Only print unique entries
tail | Print the last x lines in a file
head | Print the first x lines in a file
find | Find a file
man | Command to view manuals for each command
chown | Change ownership of a file or directory
chmod | Change permissions of a file or directory
touch | Create an empty file or set a timestamp on a file

## Home Shortcut

The tilde ( `~` ) is a short hand for your home directory.  If you type the following you will go back to your home directory.

```shell
cd ~/
```

## Finding Files

I pulled the 2018 Columbus Clippers player stats to provide the file we are going to work with today.

The file is called findme.txt and it is somewhere in the /tmp directory but we need to find it first.

* Finding the file

```shell
find /tmp -name 'findme.txt' 
```

## Copy Files

* The location of the file is a pain.  Let copy it to a better location

```shell
cp path/to/findme.txt ~/findme.txt
```

## Moving / Renaming Files

* Lets rename the file

```shell
mv findme.txt data.txt
```

## Viewing Files

* Let's look at the file

```shell
cat data.txt
```

## Show Lines In A File

* How many lines are in the file

```shell
wc -l data.txt
```

* Show only the first 5 lines of the file

```shell
head -5 data.txt
```

* Show only the last 3 lines of the file

```shell
tail -3 data.txt
```

## Grep

* Show only right fielders, `RF`

```shell
grep 'RF' data.txt
```

## Sorting

* Sort the player list by name alphabetically

```shell
sort data.txt
```

```shell
cat data.txt | sort
```

## Redirection

Redirection allows you to send the output of a command to file.  The following redirection will redirect STDOUT (standard out).

The STDOUT redirector uses the `>` symbol.

```shell
cat FILE > file.txt
```

* Append to a file

```shell
cat FILE > file.txt
cat FILE >> file.txt
```

More redirection will be covered later.

* Since the header is still part of output, lets remove that

```shell
tail -28 data.txt > players.txt
```

## Awk

* Show only player names and home runs

```shell
awk -F "," '{ print $1 " " $3 }' players.txt
```

* Change the previous output to say `PLAYER has scored HR home runs'

```shell
awk -F "," '{ print $1 " has scored " $3 " home runs" }' players.txt
```

## Sed

* Add the text `Player: ` in front of each player

```shell
sed 's/^/Player: /' players.txt


The `^` means the start of a line.

A `$` means the end of a line.
```

## Sorting Part Two

*  Sort the player list, without the header, with the most home runs first

```shell
sort -t , -k 3 -n -r players.txt
```

## Using Pipes

* Show only the player's first names and how many times that name appears

```shell
awk -F "," '{print $1}' players.txt | sort | awk '{print $1}' | uniq -c | sort
```

## Awk Part Two

* Print the total number of home runs scored by the team

```shell
awk -F "," '{total += $3} END {print total}' players.txt
```

## Tail Part two

The tail command can also be used to follow the output of a file being written to.  Normally, this would be a log file.

The `-f` argument means `follow`.

```shell
tail -f /tmp/current_time.log
```

The print_time.sh script will output the current time to /tmp/current_time.log which can be following with tail -f

## Grep Part Two

Grep provides some other useful arguments when doing different kinds of searches.

### Show filename containing matches

By default when grep is being use to search over multiple files you want the filename where matches were found to be returned.

The `-H` argument shows filenames containing matches.  On Linux this is a default action.

### Ignore binary files

Sometimes a text string you are looking for is in a binary file but you want to ignore binary files.

The `-I` argument ignores binary files.

### Ingore case

By default grep performs a case sensitive search.  What if you know the word you are looking for but you do not know th case?

The `-i` argument provies case insensitive searches.

```shell
grep -i NAME /tmp/name*
```

### Recursive search

If you know a directory tree of files contains something you are looking for you can perform a recursive search to look in all sub directories of the directory you perform the grep command.

The `-r` argument will perform a recursive search.

Note: If you want to follow symbolic links use the `-R` argument.

### Return the line number of matches

If you are dealing with files which contain many lines, 1000s, it is helpful for grep to return the line number of the match.

The `-n` argument will return the line number.

### Invert your match

Sometimes instead of searching for something you want to not search for something.  A good example are looking at a large file while removing comments. Use the `-v` argument to invert your match

```shell
grep -v '^#' /tmp/comments.txt
```

## Sed Part Two

Sometimes you encounter files that have lot of empty lines and you desire to give rid of them so you only see the relevan text.

Recall earlier it was stated that `^` represents the start of a line and that `$` represents the end of a line.  In sed the `d` modifier means `delete`.

```shell
sed '/^$/d' /tmp/comments_newlines.txt
```

To extend the previous grep match inversion, we can remove the all lines that start with a # and then pipe the output to sed to remove new lines.

```shell
grep -v '^#' /tmp/comments_newlines.txt | sed '/^$/d'
```

## Redirection Part Two

When it comes to redirection there are three file descriptors that are primarily used.

Value | File Descriptor Name | Human Readable
----- | -------------------- | -------------- 
0 | STDIN | Stanard In
1 | STDOUT | Standard Out
2 | STDERR | Standard Error

In a large number of cases, you will really only ever deal with STDOUT.  As we talked about earlier we know that `>` redirects STDOUT.  There is a also a concept of STDERR (standard error).  

Normally, STDOUT and STDERR will both print out to the screen.

```shell
$ ./out_err.sh 
I am writing to STDOUT
I am writing to STDERR
```

If you only eve want to see one of the outputs, redirect the other to /dev/null or to a file.

```shell
$ ./out_err.sh 1> /dev/null
I am writing to STDERR

or

$ ./out_err.sh 2> stderr

or

$ ./out_err.sh 2> /dev/null
I am writing to STDOUT

or

$ ./out_err.sh 1> stdout

or

./out_err.sh 1> stdout 2> stderr
```

### Redirect STDERR to STDOUT

Sometimes you want both STDERR and STDOUT to go to the same file.

```shell
./out_err.sh > both_stdout_stderr 2>&1
```

## Changing Ownership

* Changing ownership of a file or directory

```shell
chown USER:GROUP [file|directory]
```

* Change owner to `root` of file `root_owner`

```shell
touch root_owner
chown root: root_owner
```

## Changing Permissions

```shell
drwxr-xr-x  3 mike users   4096 Jul 11 21:33  Pictures
-rw-r--r--  1 mike users    205 Sep 12  2017  rsync.exclude
-rwx------  1 mike users    644 Sep 12  2017  rsync_me.sh


- --- --- ---
|  |   |   |- other ---- rwx
|  |   |----- group ---- rwx    
|  | -------- user ----- rwx
|------------ type ----- d,c,l,s

r w x
| | |- 1
| |--- 2
|----- 4

```

### Octal Method

```shell
chmod UGO [file|directory]

U - user
G - group
O - other
```

Create a read only file - owner only

```shell
touch readonly
chmod 400 readonly
ls -l readonly
-r-------- 1 mike users 0 Jul 28 15:22 readonly
```

Create a write only file - owner only

```shell
touch writeonly
chmod 200 writeonly
ls -l writeonly
--w------- 1 mike users 0 Jul 28 15:21 writeonly
```

Create an executable file only - owner only

```shell
touch execonly
chmod 100 execonly
ls -l execonly
---x------ 1 mike users 0 Jul 28 15:20 execonly
```

Create a read and write file only - owner only

```shell
touch readwriteonly
chmod 600 readwriteonly
ls -l readwriteonly
-rw------- 1 mike users 0 Jul 28 15:24 readwriteonly
```

* What is the command for a read/write/executable file?

* What is the command for a read only file for user, group, other?

### Text Method

This method is more powerful because it provides more options and flexibility but it can be more verbose when you want to set permissions.

```shell
chmod [ugoa]([-+=]([rwxXst] [file|directory]
```

Create a read only file - owner only

```shell
touch readonly
chmod u=r,g-rwx,o-rwx readonly
ls -l readonly
-r-------- 1 mike users 0 Jul 28 15:22 readonly
```

Create a write only file - owner only

```shell
touch writeonly
chmod u=w,g-rwx,o-rwx writeonly
ls -l writeonly
--w------- 1 mike users 0 Jul 28 15:21 writeonly
```

Create an executable file only - owner only

```shell
touch execonly
chmod u=x,g-rwx,o-rwx execeonly
ls -l execonly
---x------ 1 mike users 0 Jul 28 15:20 execonly
```

Create a read and write file only - owner only

```shell
touch readwriteonly
chmod u=rw,g-rwx,o-rwx readwriteonly
ls -l readwriteonly
-rw------- 1 mike users 0 Jul 28 15:24 readwriteonly
```

* What is the command for a read/write/executable file?

* What is the command for a read only file for user, group, other (everyone)?

### Permissions and Security

Why are the following permissions bad?

```shell
-rwxrwxrwx 1 mike users 0 Aug  3 16:14 test
```

## Resources

* https://github.com/mikeplem/lunchnlearn

* man pages

  * man `command`

* Julia Evans

She works on the infrastructure team at Stripe.  She has a wonderful ability of distilling down concepts to their simplest parts,

  * https://twitter.com/b0rk/media

  * https://jvns.ca/


https://www.tldp.org/guides.html

https://www.computerworld.com/article/2598082/linux/linux-linux-command-line-cheat-sheet.html

https://www.tecmint.com/linux-commands-cheat-sheet/

https://learncodethehardway.org/unix/bash_cheat_sheet.pdf

https://www.linode.com/docs/tools-reference/tools/

https://wiki.archlinux.org/index.php/File_permissions_and_attributes

https://en.wikipedia.org/wiki/File_descriptor
