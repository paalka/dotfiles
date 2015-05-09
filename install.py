#!/usr/bin/env python
# -*- coding: utf-8 -*-

from subprocess import call
import os

CWD = os.getcwd()
HOME_DIR =  os.path.expanduser('~')

print "Initilizing submodules..."
call(["git", "submodule", "update", "--init"])

print "Updating submodules..."
call(["git", "submodule", "foreach", "git", "pull"])

# Find out which subdirectories to ignore
to_ignore = []
try:
    with open("ignore_symlink") as inputfile:
        to_ignore = inputfile.read().split()
except IOError:
    pass

print "Creating symlinks..."
for item in os.listdir(CWD):
    item_path = os.path.join(CWD, item)
    if not item.startswith(".") and os.path.isdir(item_path) and item not in to_ignore:

        for item2 in os.listdir(item_path):
            curr_item = os.path.join(item, item2)
            if not item2.startswith(".") and curr_item not in to_ignore:

                path_to_link = os.path.join(HOME_DIR, "." + item2)
                real_file = os.path.join(CWD, curr_item)

                if os.path.islink(path_to_link) or os.path.isfile(path_to_link) or os.path.isdir(path_to_link):
                    print path_to_link + " already exists. Skipping."
                else:
                    print "Creating " + real_file + " -> " + path_to_link
                    os.symlink(path_to_link, real_file)


print "Setting up zprezto and setting zsh as the default shell..."
call("zsh/zprezto_setup")
