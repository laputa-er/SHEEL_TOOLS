#! /bin/zsh -y
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-3-22 MengQingshen First release

function test_get_absolute_path_by_relavent_path () {
    
}

#-----------------------------------------------------------------------------
# shunit2 functions
#

function oneTimeSetUp () {
    excuteImport ${CURSHELL_DIR}
}

# @param {string} $1 The path of the shell script it self.
function excuteImport () {
    . $1/../sources/common/mqs_functions.sh
    . $1/../config/rename.sh
    . $1/../sources/rename/functions.sh
}

CURSHELL_DIR=$(dirname $0)
SHUNIT_PARENT=$0

[ -n "${ZSH_VERSION:-}" ] && setopt shwordsplit
. ${CURSHELL_DIR}/../shunit2-2.1.6/src/shunit2