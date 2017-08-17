#! /bin/bash
#print lines as they are executed
set -x
#exit at the first error
set -e

make_backup=true
dry_run=''
reverse_patch=false

while [ $# -gt 0 ]
do 
  case $1 in 
  # File option, followed by filename
  --dry-run) dry_run=--dry-run
    ;;
  --no-backup) make_backup=false
    ;;
  --reverse-patch) reverse_patch=true
    ;;
# Unrecognized option
  -*) echo "$0: $1: unrecognized option" >&2
    ;;
  **) break
    ;;
  esac
 
  # shift for next option
  shift
done


if [ ${make_backup} = true ]
then
   backup_switches='-b -V numbered'
else
   backup_switches=''
fi

if [ ${reverse_patch} = true ]
then
   reverse_switches='-R'
else
   reverse_switches=''
fi

#echo "${backup_switches} ${dry_run} ${reverse_switches}"
patch ${backup_switches} ${dry_run} ${reverse_switches} < job.patch
patch ${backup_switches} ${dry_run} ${reverse_switches} < process.patch
patch ${backup_switches} ${dry_run} ${reverse_switches} < main.patch

