#!/usr/bin/env python
# -*- coding: utf-8 -*-

from subprocess import call
import os

def is_link_or_file(path):
    """
    Check whether the given filepath 'path' leads to a valid file, symlink or
    directory. Returns True/False depending on whether it is a valid
    file/symlink/directory.
    """

    return os.path.islink(path) \
            or os.path.isfile(path) \
            or os.path.isdir(path)


def create_symlink(path_to_link, real_file):
    """
    Create a symbolic link leading from the file 'real_file' to the path
    'path_to_link'.
    """

    if is_link_or_file(path_to_link):
        print path_to_link + " already exists. Skipping."
    else:
        print "Creating " + real_file + " -> " + path_to_link
        os.symlink(real_file, path_to_link)


def create_symlinks(directory, target_dir, ignore):
    """
    Loop through the directory 'directory', and create a symlink for each file
    and folder, unless the folder/file is in the ignore list. The symlink leads
    to a file/folder in the target folder 'target_dir' and the file-/foldername
    is prefixed with a dot.
    """

    print "Creating symlinks..."
    for item in os.listdir(directory):
        if item not in ignore and not item.startswith("."):
            item_path = os.path.join(directory, item)

            path_to_link = os.path.join(target_dir, "." + item)
            real_folder = os.path.join(directory, item)

            create_symlink(path_to_link, real_folder)

            if os.path.isdir(item_path) and not item + "/*" in ignore:
                for item2 in os.listdir(item_path):
                    if not item2.startswith("."):
                        curr_item = os.path.join(item, item2)

                        if curr_item not in ignore:
                            path_to_link = os.path.join(target_dir, "." + item2)
                            real_file = os.path.join(directory, curr_item)

                            create_symlink(path_to_link, real_file)


def init_git_submodules():
    """
    Initilize all the submodules in the .gitmodules file.
    """

    print "Initilizing submodules..."
    call(["git", "submodule", "update", "--init"])


def update_git_submodules():
    """
    Pull the latest version of the submodules, so that they are all up-to-date.
    """

    print "Updating submodules..."
    call(["git", "submodule", "update", "--recursive"])


def get_files_to_ignore(ignore_file):
    """
    Read the file 'ignore_file', which should contain the path to the folders
    which are to be ignored when creating symlinks. Returns a list of strings
    containing the folders/files to ignore.
    """

    to_ignore = []
    try:
        with open(ignore_file) as inputfile:
            to_ignore = inputfile.read().split()
    except IOError:
        pass

    return to_ignore


if __name__ == "__main__":
    CWD = os.getcwd()
    HOME_DIR = os.path.expanduser('~')

    init_git_submodules()
    update_git_submodules()

    to_ignore = get_files_to_ignore("ignore_symlink")
    create_symlinks(CWD, HOME_DIR, to_ignore)
