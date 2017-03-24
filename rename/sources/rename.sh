#! /bin/zsh -y
# This program can renames multiple files.
# Author: eli01linux@gmail.com(MengQingshen)
# History:
# 	2017-03-20 MengQingshen First release
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

CURSHELL_DIR=$(dirname $0)
TMP_RELAVENT_DIR="${CURSHELL_DIR}/../tmp"
LOG_RELAVENT_DIR="${CURSHELL_DIR}/../log"

# include config and libs
. ${CURSHELL_DIR}/./lib/mqs_funs.sh
. ${CURSHELL_DIR}/./config.sh
. ${CURSHELL_DIR}/./functions.sh


# create dir
mkdir -p ${TMP_RELAVENT_DIR}
mkdir -p ${LOG_RELAVENT_DIR}

# init path
TMP_DIR="$(get_absolute_path_by_relavent_path ${TMP_RELAVENT_DIR})"
OLD_NAMES_FILE="${TMP_DIR}/old_names_file"
NEW_NAMES_FILE="${TMP_DIR}/new_names_file"


LOG_DIR="$(get_absolute_path_by_relavent_path ${LOG_RELAVENT_DIR})"
LOG_FILE="${LOG_DIR}/$(date +"%Y-%m-%d-%H-%M-%S")"

# generate old names to temporary file
OLD_NAMES="$(get_all_files_to_be_rename ${DIR_FOR_FILES_TO_BE_RENAMEED} ${REGEXP_OF_FILES_TO_BE_REPLACED})"
[ -z "${OLD_NAMES}" ] && print_error "No file found to be renamed."
echo "${OLD_NAMES}" | nl > ${OLD_NAMES_FILE}

# generate new names to temporary file
NEW_NAMES="$(echo "${OLD_NAMES}" | sed "s/${REGEXP_OF_SEARCH}/${STR_FOR_REPLACE}/g")"
echo "${NEW_NAMES}" | nl > ${NEW_NAMES_FILE}

# generator log info
# join ${OLD_NAMES_FILE} ${NEW_NAMES_FILE} |  awk '{printf $1 "\t" $2 "\t" $3 "\n"}' | swk > ${LOG_FILE}

print_info "Preview the rename operation."
# print_info "$(cat $LOG_FILE)"
preview "${OLD_NAMES}" "${NEW_NAMES}"

ANSWER=$(show_prompt "Here be dragons. Continue?(Y/N):")  

if [[ "${ANSWER}" =~ ^[Yy]$ ]]
    then
        start_rename "${OLD_NAMES}" "${NEW_NAMES}"
    else
        print_error "Canceled."
fi
