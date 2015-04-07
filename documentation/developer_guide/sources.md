---
title: Source Code
---

All of the SlipStream source code is stored in [GitHub] and can be
browsed through the GitHub web interface or checked out with a [git]
client.

# Prerequisites

You must have a working [git] client installed on your development
machine.  There are a number of command-line and graphical clients
that can be downloaded and used for all major operating systems.

You must also have a [Java] development environment (1.7+) and [Maven]
3 installed.

Ensure that all of these are installed and working correctly before
proceeding. 

# Bootstrapping

The major SlipStream components are stored in separate repositories on
GitHub.  To build the entire system, all of the component repositories
must be cloned locally.  To make this process easier, we've created a
"bootstrap" repository that automates the process.

From the command line (or from your graphical git client), checkout
the bootstrap repository.  The command for this is:
```
$ git clone https://github.com/slipstream/SlipStreamBootstrap
```
This is a public GitHub URL, so you should be able to clone the
repository from here either with or without a GitHub account.

# Obtaining SlipStream Components

Once you've checked out the SlipStreamBootstrap repository, descend
into the root of that repository.  From there, you can then use maven
to clone all of the SlipStream repositories.
```
$ cd SlipStreamBootstrap
$ mvn generate-sources
```
All of the SlipStream component repositories will be cloned in the
same directory.  The checkout by default will be at the HEAD of the
master branch.  All of the repositories start with "SlipStream".

## Public GitHub URLs

The above procedure will use the GitHub developer URLs, which require a
GitHub account.  **If you do not have a GitHub account**, then use the
command:
```
$ mvn -P public generate-sources
```
instead.  This uses the public URLs for the repositories.

## Branches or Tags

By default, the **master** branch will be checked out.  If you want a
different branch or tag, then use the following command:
```
$ mvn -Dslipstream.version.default=master generate-sources
```
setting the value of "master" to the desired branch or tag.  This will
consistently use the same branch or tag for all components.  The tags
for candidate and stable releases look like "v2.5-community".

Although not recommended, it is sometimes useful to mix and match
versions of different components.  Look at the `pom.xml` file for the
properties to set from the command line if you want to do this.


[GitHub]: https://github.com
[git]: http://git-scm.com
[Java]: http://java.com/en/
[Maven]: https://maven.apache.org/

