#! /bin/zsh
# A library of some functions frequently used among my shell scripts.
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-3-21 MengQingshen First release

function is_zsh () {
    echo [ -n "${ZSH_VERSION:-}" ]
}

# @param{string} $1 The relavent path.
function get_absolute_path_by_relavent_path () {
    if [ -e $1 ]
        then
            echo "$(get_parent_path $1)/$(basename $1)"
        else
            print_error "'$1' is neither a file nor a directory."
    fi
}

function get_current_pwd () {
    echo "$(pwd)"
}

#@param{string} $1 child path, relavent and absolute are both fine.
function get_parent_path () {
    local PARENT_PATH="$(cd $(dirname $1); get_current_pwd)"
    echo "${PARENT_PATH}"
}

# @param{string} $1 The desc of the error
function print_error () {
    echo -e "\e[1;31m${1}\e[0m"
    exit 1
}

# @param{string} $1 The text of the info
function print_info () {
    echo "${1}"
}

# @param{string} $1 The desc of the success
function print_success () {
    echo -e "\e[1;32m${1}\e[0m"
}

function return_to_old_pwd () {
    cd -
}
