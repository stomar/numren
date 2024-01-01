numren
======

`numren` is a command line tool (written in [Ruby][Ruby])
that renames files with a filename consisting of a number part
and a name part, like e.g. `01_Sample.txt`.
Only the number part is changed, according to the given number.

What is it good for?
--------------------

I usually organize my material for a project, talk, or the like
in a logical order using files with numbered filenames, like e. g.

    01_Introduction.txt
    02_Gnu_Migration.odt
    02_Gnu_Migration.mpg
    03_Gnu_Conservation.txt
    04_Gnat_Populations.txt
    ...

However, I often end up changing the order of my material.
`numren` makes the task of renaming these files easier.

Note that the number and the name part must be separated by an underscore.
Also, the name parts without number should be unique, filenames like
`01_Example.txt`, `02_Example.txt`, `03_Example.txt`, ...
probably will cause trouble.

Examples
--------

On Linux or OS X use the program as shown in the examples below.
On Windows use `"ruby numren ..."` instead.

* `numren 01_Sample.txt 5`

    renames `01_Sample.txt` to `05_Sample.txt`

* `numren 01_Sample.txt +4`

    renames `01_Sample.txt` to `05_Sample.txt`

* `numren 10_Sample.txt -- -1`

    renames `10_Sample.txt` to `09_Sample.txt`

* `numren 01_Sample.txt 001`

    renames `01_Sample.txt` to `001_Sample.txt`

* `numren -d 2 010_Sample.txt`

    renames `010_Sample.txt` to `10_Sample.txt`

Installation
------------

Place `numren` into your search path.

On a Linux system you can use `[sudo] rake install`
to install `numren` and its man page to `/usr/local`.

Requirements
------------

`numren` is written in [Ruby][Ruby], so Ruby must be installed on your system.

Documentation
-------------

Use `numren --help` to display a brief help message.

If you installed `numren` using `rake install` you can read
its man page with `man numren`.

Reporting bugs
--------------

Report bugs on the `numren` home page: <https://github.com/stomar/numren/>

License
-------

Copyright &copy; 2011-2024 Marcus Stollsteimer

`numren` is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License version 3 or later (GPLv3+),
see [www.gnu.org/licenses/gpl.html](http://www.gnu.org/licenses/gpl.html).
There is NO WARRANTY, to the extent permitted by law.


[Ruby]: http://www.ruby-lang.org/
