# ansible-container

*Performing the tasks below should take less than 5 minutes to complete. There are only 3 actual tasks to perform.* Extra information is provided along the way for different levels of experience.

*This document expects that you have some basic understanding of Linux and command line experience.*

First you need to clone this repo. With the following command you can place this repo in a directory of your choice. Note the trailing period which means to clone into the current directory. Removing the trailing period will clone this into its own directory within the one you have changed to in the `cd` command.

```
cd to/your/directory/of/choice
git clone git@github.com:k7faq/ansible-container.git .
```

### EXAMPLES
Both of these examples accomplish the same task.

```
mkdir /user/home/myuser/containers/; cd $_
git clone git@github.com:k7faq/ansible-container.git .
```

OR

```
mkdir /user/home/myuser/containers/
cd /user/home/myuser/containers/
git clone git@github.com:k7faq/ansible-container.git .
```

Then you need to build the container using the following command FROM WITHIN the directory you cloned your repo into. You need to build the container. A shell script is provided:

```
./build
```

You now have a container built named `ansible_2.7`.

During the build process above an alias was created on your behalf. Provided your Linux distro uses a `.bash_profile` in your home directory to store custom settings you should be good to go using the following commands:


If all has succeded then you should be greeted with success reports like this:

```
PLAY RECAP *****************************************************************

localhost                  : ok=1    changed=1    unreachable=0    failed=0   

```

### How do I use this?

Following are some example use cases:

```
ansi ansible-playbook configure_env.yml -vvvv
```

```
ansi ansible --version
```

### Some notes of interest

If you take time to look at the contents of the run command you will find that your `.ssh/` directory in your user home directory is passed to the container. Why? Simply because of how Ansible works using ssh keys to connect to resources. In my case I only use a username and password during the initial startup of a VM. This initial step creates the user id and establishes the appropriate key(s) for future connections. Thus each subsequent connection will utilize the key(s) in my user home directory -OR- from the location specified. 

### HELP! All has failed

If the above failed, please look in your `~/.bash_profile` file to verify an alias of `ansi` was created for you. If you find one then please log out and log back into your terminal window and try again. If still no success then try one of the following:

- Create a custom shell script
  - This will need to be in your $PATH
  - use `echo $PATH` to verify your options
  - typically `/usr/local/bin/` is a great place for these
- Create a sym(bolic) link named ansi
 
```
echo `sudo ln -sf ${PWD}/run /usr/local/bin/ansi
ll /usr/local/bin/ansi
```
  
- if not using Ubuntu (or a Debian product) 
  - verify which file is used by the OS to establish your users environment at login