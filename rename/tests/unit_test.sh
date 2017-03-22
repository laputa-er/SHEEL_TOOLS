#! /bin/zsh -y
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-3-21 MengQingshen First release
function testItCanGetFilesToBeNamed () {
	assertNotNull 'Expected display all the filename to be renamed.' \
			"$(get_all_files_to_be_rename ${DIR_FOR_FILES_TO_BE_RENAMEED} ${REGEXP_OF_FILES_TO_BE_REPLACED})"
}

#-----------------------------------------------------------------------------
# shunit2 functions
#
function oneTimeSetUp () {
	excuteImport ${CURSHELL_DIR}
}

# @param {string} $1 The path of the shell script it self.
function excuteImport () {
	. $1/../sources/lib/mqs_funs.sh
	. $1/../sources/config.sh
	. $1/../sources/functions.sh
}

CURSHELL_DIR=$(dirname $0)
SHUNIT_PARENT=$0

setopt shwordsplit
. ${CURSHELL_DIR}/../shunit2-2.1.6/src/shunit2