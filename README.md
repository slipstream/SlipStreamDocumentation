# SlipStream is now deprecated -> replaced by https://github.com/nuvla

SlipStream Documentation Sources
================================

This repository contains the **sources** for all of the SlipStream
documentation.  If you are looking for the **documentation itself**,
visit the [documentation website][docs] instead.

Overview
--------

All of the SlipStream documentation is written in [reStructured
Text][reST] and then transformed into HTML via [Sphinx][sphinx].  The
generated pages are then built on the ReadTheDocs website.

To update or add documentation:

 - Clone this repository.
 - Checkout the `draft` branch.
 - Edit or add source files in the `docs` subdirectory, organizing
   them hierarchically.
 - Test the changes by running Sphinx locally and viewing the result.
 - Commit the changes to the repository and ask people to review your
   changes. 
 - After review, merge the changes into the `master` branch.

The following sections describe each of these steps in more detail.

**Pushing changes to the `draft` and `master` branches trigger
webhooks that make those versions visible on the ReadTheDocs site.**

Clone Sources
-------------

All of the sources are contained in this git repository on GitHub. To
checkout the sources:
```
$ git clone git@github.com:slipstream/SlipStreamDocumentation.git
```
If you don't have write access to this repository, then use one of the
read-only URLs for it.

Create Branch
-------------

Checkout the `draft` branch for your changes. 
```
$ git checkout draft
```
Push the changes to GitHub when you want to see the rendered draft
material on the ReadTheDocs site. 

Editing Documentation
---------------------

All of the source documentation is written in [reStructured
Text][reST] format.

Simply update the documentation files in the `docs` subdirectory,
using the `draft` branch.

When updating or adding sources, please:
 - Ensure the files remain as plain text in US-ASCII encoding.
 - Use Unix line endings (and not Windows).
 - Use spaces and not tabs.
 - Wrap lines at column 72 and flow text.

Using a consistent style in text format makes it easier to maintain
the documentation.

Test Changes
------------

To test your changes to the documentation, you should run
[Sphinx][sphinx] locally.

Good instructions for installing the necessary dependencies can be
found on the Sphinx documentation website and on the [ReadTheDocs
stylesheet README][rtdcss].  This essentially comes down to the
```
$ pip install Sphinx sphinx-autobuild sphinx-rtd-theme
```
You will also need to have the `make` command installed for unix-like
machines, or use the `make.bat` script on Windows.

From the root of the repository just run:
```
$ make clean; make html
```
The generated HTML documentation will be in `build/html` with the root
file `build/html/index.html`.  

Commit Changes
--------------

This is a standard git repository, so committing the changes means
just following the standard git workflow.  Push your branch to the
GitHub repository.

Publishing Changes
------------------

The changes will be published on the ReadTheDocs site automatically
when changes to the `draft` or `master` branches are pushed.  It may
take a couple of minutes for the build process to run on the
ReadTheDocs site.  


[docs]: http://ssdocs.sixsq.com
[reST]: http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html
[sphinx]: http://sphinx-doc.org
[rtdcss]: https://github.com/snide/sphinx_rtd_theme
