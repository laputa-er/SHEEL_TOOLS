#! /bin/zsh -y
# This program can renames multiple files.
# Author: eli01linux@gmail.com(MengQingshen)
# History:
# 	2017-03-20 MengQingshen First release
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

CURSHELL_DIR=$(dirname $0)
TMP_RELAVENT_DIR="${CURSHELL_DIR}/../tmp"
LOG_RELAVENT_DIR="${CURSHELL_DIR}/../../log"

# include config and libs
. ${CURSHELL_DIR}/../common/mqs_functions.sh
. ${CURSHELL_DIR}/../../config/rename.sh
. ${CURSHELL_DIR}/./functions.sh

# create dir
mkdir -p ${TMP_RELAVENT_DIR}
mkdir -p ${LOG_RELAVENT_DIR}

# create path
TMP_DIR="$(get_absolute_path_by_relavent_path ${TMP_RELAVENT_DIR})"
OLD_NAMES_FILE="${TMP_DIR}/old_names_file"
NEW_NAMES_FILE="${TMP_DIR}/new_names_file"

LOG_DIR="$(get_absolute_path_by_relavent_path ${LOG_RELAVENT_DIR})"
LOG_FILE="${LOG_DIR}/$(get_name_of_log_file "rename")"

# generate old names
OLD_NAMES="$(get_all_files_to_be_rename ${DIR_FOR_FILES_TO_BE_RENAMEED} ${REGEXP_OF_FILES_TO_BE_REPLACED})"
[ -z "${OLD_NAMES}" ] && print_error "No file found to be renamed."
echo "${OLD_NAMES}" | nl > ${OLD_NAMES_FILE}

# generate new names
NEW_NAMES="$(echo "${OLD_NAMES}" | sed "s/${REGEXP_OF_SEARCH}/${STR_FOR_REPLACE}/g")"
echo "${NEW_NAMES}" | nl > ${NEW_NAMES_FILE}

print_info "Preview the rename operation."
# preview
PREVIEW="$(preview "${OLD_NAMES}" "${NEW_NAMES}")"
echo "${PREVIEW}"

# here we go
ANSWER=$(show_prompt "Here be dragons. Continue?(Y/N):")  

if [[ "${ANSWER}" =~ ^[Yy]$ ]]
    then
        start_rename "${OLD_NAMES}" "${NEW_NAMES}"
        echo "${PREVIEW}" > ${LOG_FILE}
    else
        print_error "Canceled."
fi
