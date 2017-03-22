#! /bin/zsh -y
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-3-21 MengQingshen First release
function testItCanProvideRightResultLog () {
	cd ../sources
	
	./rename.sh
	local LOG_FILE_PATH = "../log/rename_$(date +"%Y-%m-%d").txt"

	assertTrue 'Expected generate list of renamed files under log dir.' [ -f ${LOG_FILE_PATH} ]
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