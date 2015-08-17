#!/bin/bash

WORKDIR='/home/datum'
NOTEBOOK_DIR=$WORKDIR'/notebooks'
#[-d '/logdir' ] && LOG_DIR='/logdir'

OPTIONS="--port=8080 --no-browser"
#[-n "$*" ] && OPTIONS=$*

ipython notebook $OPTIONS --ip=* --notbook-dir=$NOTEBOOK_DIR #&>> $LOG_DIR/notebook.log
