#! /bin/zsh -y
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-03-25 MengQingshen First release
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
CURSHELL_DIR=$(dirname $0)
PATH_LIST_OF_FILES="${CURSHELL_DIR}/../../config/delete_list.txt"

# include config and libs
. ${CURSHELL_DIR}/../common/mqs_functions.sh
. ${CURSHELL_DIR}/../../config/delete.sh
. ${CURSHELL_DIR}/./functions.sh

# generate files name to delete
ALL_FILES_TO_DELETE="$(get_all_files_to_delete "${DIR_OF_FILES_TO_DELETE}" "${REGEXP_OF_FILES_TO_DELETE}" "$(cat ${PATH_LIST_OF_FILES})")"

# preview
print_info "Preview the rename operation."
preview "${ALL_FILES_TO_DELETE}" "${DIR_OF_FILES_TO_DELETE}"

# here we go
ANSWER=$(show_prompt "Here be dragons. Continue?(Y/N):")  

if [[ "${ANSWER}" =~ ^[Yy]$ ]]
    then
        start_delete "${ALL_FILES_TO_DELETE}" "${DIR_OF_FILES_TO_DELETE}"
    else
        print_error "Canceled."
fi