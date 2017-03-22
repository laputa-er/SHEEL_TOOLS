#! /bin/zsh -y
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-03-21 MengQingshen First release

# @param {string} $1 Parent dir of the files to be renamed.
# @param {string} $2 Regular expression to select the files to be renamed among all files under the dir.
# @return {array} All the files to be renamed.
function get_all_files_to_be_rename () {
	echo "$(ls $1 | grep $2)"
}

