SlipStream Documentation Sources
================================

This repository contains the **sources** for all of the SlipStream
documentation.  If you are looking for the **documentation itself**,
visit the [associated GitHub Pages site][docs] instead.

Overview
--------

All of the SlipStream documentation is written in [Markdown][markdown]
and then transformed into HTML via [Jekyll][jekyll].  The generated
pages are then pushed into the `gh-pages` branch which are then served
by [GitHub Pages][pages].

To update or add documentation:
 - Check out the sources.
 - Edit or add source file in the `documentation` subdirectory,
   organizing them hierarchically.
 - Test the changes by running Jekyll locally and viewing the result.
 - Commit the changes to the repository.
 - Publish the updated pages.

The following sections describe each of these steps in more detail.

Checkout Sources
----------------

All of the sources are contained in this git repository on GitHub. To
checkout the sources:
```
$ git clone --recursive git@github.com:slipstream/SlipStreamDocumentation.git
```
If you don't have write access to this repository, then use one of the
read-only URLs for it.

**NOTE: the `--recursive` option on the clone command is mandatory.**
This pulls in the JDoc Jekyll plugin that is used to build the
hierarchical documentation.

Editing Documentation
---------------------

All of the source documentation is written in [Markdown][markdown]
format, more specifically the [Kramdown][kramdown] variant.

Simply update the documentation files (in Markdown format) in the
`documentation` subdirectory.  Either use the `master` branch or your
own branch for changes.  **Do not make any changes directly on the
`gh-pages` branch.**

When updating or adding sources, please:
 - Ensure the files remain as plain text in US-ASCII encoding.
 - Use Unix line endings (and not Windows).
 - Use spaces and not tabs.
 - Wrap lines at column 72 and flow text.

Using a consistent style in text format makes it easier to maintain
the documentation.

NOTE: Jekyll should be able to handle UTF-8 encodings, but 
unfortunately doesn't seem to do so correctly.  This needs to be
investigated.

Test Changes
------------

To test your changes to the documentation, you should run
[Jekyll][jekyll] locally.  Good instructions for installing the
necessary dependencies and configurating your machine are available
from the GitHub pages guide; see the [Using Jekyll][jekyll-install]
page. 

Once you've got everything installed, starting up a local server is as
simple as running the command:
```
$ bundle exec jekyll serve
```
The updated documentation will then appear on your local machine at:
```
http://localhost:4000/SlipStreamDocumentation
```
Simply point your browser to that URL.  Recent versions of Jekyll
(v2.4+) will watch for changes in the sources and automatically update
the website with changes.

Commit Changes
--------------

This is a standard git repository, so committing the changes means
just following the standard git workflow:
```
$ git add .
$ git commit -m "update documentation"
$ git push
```
Note that this will save your changes in the central repository but it
will **not** publish the changes to the GitHub Pages website!

Publishing Changes
------------------

To publish the changes simply run the command:
```
$ rake
```
This will compile the site with Jekyll and then push all of the
changes into the `gh-pages` branch.  From there, the updates will be
published by GitHub Pages.


[docs]: http://slipstream.github.io/SlipStreamDocumentation
[markdown]: http://daringfireball.net/projects/markdown/
[kramdown]: http://kramdown.gettalong.org/quickref.html
[jekyll]: http://jekyllrb.com
[jekyll-install]: https://help.github.com/articles/using-jekyll-with-pages/
[pages]: https://pages.github.com
