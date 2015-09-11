SlipStream Documentation Sources
================================

This repository contains the **sources** for all of the SlipStream
documentation.  If you are looking for the **documentation itself**,
visit the [associated GitHub Pages site][docs] instead.

Overview
--------

All of the SlipStream documentation is written in [reStructured
Text][reST] and then transformed into HTML via [Sphinx][sphinx].  The
generated pages are then pushed into the `gh-pages` branch which are
then served by [GitHub Pages][pages].

To update or add documentation:
 - Clone this repository.
 - Edit or add source files in the `docs` subdirectory,
   organizing them hierarchically.
 - Test the changes by running Sphinx locally and viewing the result.
 - Commit the changes to the repository.
 - Publish the updated pages.

The following sections describe each of these steps in more detail.

Clone Sources
-------------

All of the sources are contained in this git repository on GitHub. To
checkout the sources:
```
$ git clone git@github.com:slipstream/SlipStreamDocumentation.git
```
If you don't have write access to this repository, then use one of the
read-only URLs for it.

Editing Documentation
---------------------

All of the source documentation is written in [reStructured
Text][reST] format.

Simply update the documentation files in the `docs` subdirectory.
Either use the `master` branch or your own branch for changes.  **Do
not make any changes directly on the `gh-pages` branch.**

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
just following the standard git workflow--either using branches and
pull requests or just commiting to master.

Note that this will save your changes in the central repository but it
will **not** publish the changes to the GitHub Pages website!

Publishing Changes
------------------

To publish the changes simply run the command:
```
$ ./publish.sh
```
This will push all of the documentation to the `gh-pages` branch.


[docs]: http://slipstream.github.io/SlipStreamDocumentation
[reST]: http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html
[sphinx]: http://sphinx-doc.org
[rtdcss]: https://github.com/snide/sphinx_rtd_theme
[pages]: https://pages.github.com
