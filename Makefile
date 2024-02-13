#!/usr/bin/make -f
#
# This is my Makefile to lint all scripts in my repository. To run this
# makefile type `make all` or `make lint`. You can also lint a specific script.
#
# Using `-j N` option you can run N jobs simultaneously.
#
# This makefile requires 'ShellCheck' to lint Bash script and 'flake8' to lint
# Python scripts.
#
# Copyright (c) 2019 Emanuele Petriglia <inbox@emanuelepetriglia.com>
# All rights reserved. This file is licensed under the MIT license.

# Disable SC1091: doesn't follow other Bash sources.
shellcheck_opts = --color=always --exclude=SC1091

# Disable E261: "at least two spaces before inline comment".
flake8_opts = --max-line-length=80 --extend-ignore=E261

# Enable a more stricter typing cheking and disable cache file.
mypy_opts = --strict --no-incremental --cache-dir=/dev/null

# Get only the files that are written in Bash.
# Note that I need to use a double $ to avoid Makefile variable expansion!
bash_scripts = $(shell grep -rl -e "^\#!/usr/bin/env bash" | grep -v -e "\.swp$$")

# Get only the files that are written in Python 3.
python_scripts = $(shell grep -rl bin/* -e "^\#!/usr/bin/env python3")

.PHONY: all lint $(bash_scripts) $(python_scripts)

all : lint

lint : $(bash_scripts) $(python_scripts)

$(bash_scripts) :
	shellcheck $(shellcheck_opts) $@

$(python_scripts) :
	flake8 $(flake8_opts) $@
	-mypy $(mypy_opts) $@
