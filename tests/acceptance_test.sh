#! /bin/zsh -y
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-3-21 MengQingshen First release

function testItCanProvideRightResultLog () {
    # cd ${CURSHELL_DIR}/../sources
    
    # source ${CURSHELL_DIR}/rename.sh
    # local LOG_FILE_PATH = "${CURSHELL_DIR}/../log/rename_$(date +"%Y-%m-%d").txt"

    # assertTrue 'Expected generate list of renamed files under log dir.' [ -f ${LOG_FILE_PATH} ]
}

#-----------------------------------------------------------------------------
# shunit2 functions
#

# @param {string} $1 The path of the shell script it self.
function createSomeFilesToBeRenamed () {
    local FILES_DIR=${1}/../tmp/files_to_be_renamed
    mkdir -p ${FILES_DIR}
    touch -- ${FILES_DIR}/{-a-b-c.png,-d-e.jpg,fg.txt,hig.jpg,"-kl mn.jpg","-opq i.png","- rs t.png"}
}

# @param {string} $1 The path of the shell script it self.
function excuteImport () {
    . $1/../sources/common/mqs_functions.sh
    . $1/../config/rename.sh
    . $1/../sources/rename/functions.sh
}

function oneTimeSetUp () {
    excuteImport ${CURSHELL_DIR}
    createSomeFilesToBeRenamed ${CURSHELL_DIR}
}

CURSHELL_DIR=$(dirname $0)
SHUNIT_PARENT=$0

[ -n "${ZSH_VERSION:-}" ] && setopt shwordsplit
. ${CURSHELL_DIR}/../shunit2-2.1.6/src/shunit2