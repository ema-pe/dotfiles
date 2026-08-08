#!/usr/bin/make -f
#
# This is my Makefile to lint all scripts in my repository. To run this
# makefile type `make all` or `make lint`. You can also lint a specific script.
#
# Using `-j N` option you can run N jobs simultaneously.
#
# This makefile requires 'shellcheck' to lint Bash script and 'ruff' to lint
# Python scripts.
#
# Copyright (c) 2019-2026 Emanuele Petriglia <inbox@emanuelepetriglia.com>
# All rights reserved. This file is licensed under the MIT license.

# Disable SC1091: doesn't follow other Bash sources.
#         SC2329: this function is never invoked.
shellcheck_opts = --color=always --severity=warning --exclude=SC1091,SC2329

# Disable E261: "at least two spaces before inline comment".
ruff_opts = --line-length=80 --ignore=E261

# Get only the files that are written in Bash.
# Note that I need to use a double $ to avoid Makefile variable expansion!
bash_scripts = $(shell find . -type f -exec grep -l '^#!/usr/bin/env bash' {} +)
#bash_scripts = $(shell grep -rl -e "^\#!/usr/bin/env bash" | grep -v -e "\.swp$$")

# Get only the files that are written in Python.
python_scripts = $(shell grep -rl --exclude-dir=.git -e '^#!/usr/bin/env python$$')

.PHONY: all lint $(bash_scripts) $(python_scripts)

all : lint

lint : $(bash_scripts) $(python_scripts)

$(bash_scripts) :
	shellcheck $(shellcheck_opts) $@

$(python_scripts) :
	ruff check $(flake8_opts) $@
