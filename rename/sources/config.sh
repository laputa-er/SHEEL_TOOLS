#! /bin/zsh -y
# You should change those variables before run any shell script.
# Author: eli01linux@gmail.com(MengQingshen)
# History:
# 	2017-03-20 MengQingshen First release

# The dir containing  files which need to be renamed
DIR_FOR_FILES_TO_BE_RENAMEED='/Users/tonyearth/Downloads/ps'

REGEXP_OF_FILES_TO_BE_REPLACED='^http---o6ul1xz4z\.bkt\.clouddn\.com-img-'
# To match the part that needs to be replaced.
REGEXP_OF_SEARCH='^http---o6ul1xz4z\.bkt\.clouddn\.com-img-'

# The replacement.
STR_FOR_REPLACE=''
