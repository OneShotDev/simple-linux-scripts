#!/bin/bash

# SETTINGS
# Directories
DATA_DIR='/media/data'
BACKUP_DIR='/media/backup'
DEL_FILES_DIR='/media/backup_deleted_files'
LOG_FILES_DIR='/home/user/Documents/backup_logs'

# Colors
CYAN='\033[0;36m'
RED='\033[0;31m'
GRAY='\033[0;37m'
WHITE='\033[1;37m'

# CODE
echo -e "${CYAN}Data Backup"
echo -e "${GRAY}- - - - - - - - - - -"
echo ""
echo -e "Make sure, that your ${WHITE}DATA${GRAY} partition is mounted at \"${CYAN}$DATA_DIR${GRAY}\""
echo -e "Make sure, that your ${WHITE}BACKUP${GRAY} partition is mounted at \"${CYAN}$BACKUP_DIR${GRAY}\""
echo ""
echo "Do you want to execute the backup now? (y=yes, n=no)"
read DECISION
if [ $DECISION == "y" ] || [ $DECISION == "yes" ]; then
	DATE=$(date +%Y-%m-%d-%H-%M-%S)
	echo "executing backup now ..."
	echo ""
	rsync -ahb --backup-dir=$DEL_FILES_DIR --delete --info=progress2 --stats --log-file=$LOG_FILES_DIR/rsync_DATA_$DATE.log "$DATA_DIR/" "$BACKUP_DIR"
	echo ""
	echo "... backup finished!"
	echo -e "created log-file \"${CYAN}$LOG_FILES_DIR/rsync_DATA_$DATE.log${GRAY}\""
	NUM_FILES=$(($(cat $LOG_FILES_DIR/rsync_DATA_$DATE.log | grep "Number of files:" | cut -d" " -f7)-1))
	NUM_CREATED=$(cat $LOG_FILES_DIR/rsync_DATA_$DATE.log | grep "Number of created files:" | cut -d" " -f8)
	if [ $NUM_FILES != $NUM_CREATED ]; then
		echo -e "${RED}WARNING: There were ${NUM_CREATED} of ${NUM_FILES} files created!${GRAY}"
		echo "inspect the log file for further information"
		echo "only important if this backup is a full backup (ignore it, if it is incremetally)"
	fi
else
	echo -e "${RED}backup aborted!${GRAY}"
	echo -e "remember to do a backup manually ${WHITE}AS SOON AS POSSIBLE${GRAY} by executing \"${CYAN}data-backup.sh${GRAY}\""
fi
read
