# Since /dev/xvdb (i.e., /mnt) will tend to have the most free-space on our EC2 VMs:
BKUP_DIR=/mnt/var/data_bkups
GZIP_DIR=/mnt/var/data_bkups/gzips

DATESTAMP=`date +%F`
HOSTNAME=`hostname`
ATLPWD='!oiSQzYCij!'

# Keep old tarball backup files for one week:
PRUNELENGTH=7

S3BUCKET=ee-server-backup-us-west-2


LOGFILE=/var/log/data_bkups_$DATESTAMP.log
DUMPFILE=$BKUP_DIR/dump.file
INFOFILE=$BKUP_DIR/$HOSTNAME-info-$DATESTAMP.txt
SSTATEGZIP=$BKUP_DIR/$HOSTNAME-config-$DATESTAMP.gz
JIRAGZIP=$BKUP_DIR/$HOSTNAME-jira-$DATESTAMP.gz
CONFLGZIP=$BKUP_DIR/$HOSTNAME-confl-$DATESTAMP.gz
BAMBOOGZIP=$BKUP_DIR/$HOSTNAME-bamboo-$DATESTAMP.gz
EETARGETS="/var/atlassian/application-data /var/log/auth.log /var/log/apache2 /var/log/ufw.log /var/log/syslog /var/log/lastlog /var/log/wtmp /home /etc /root"


# if BKUP_DIR and GZIP_DIR (1st mkdir should be enough, but...) don't exist, create them:
if [ ! -e $BKUP_DIR ]; then
    mkdir -p $BKUP_DIR
elif [ ! -d $BKUP_DIR ]; then
    echo "$BKUP_DIR already exists but is not a directory"
fi

echo "mkdir BKUP_DIR returned: $?" > $LOGFILE

if [ ! -e $GZIP_DIR ]; then
    mkdir -p $GZIP_DIR
elif [ ! -d $GZIP_DIR ]; then
    echo "$GZIP_DIR already exists but is not a directory"
fi

echo "mkdir GZIP_DIR returned: $?" > $LOGFILE

# Build file containing host state information:

echo -e "df -h output: \n" > $INFOFILE
echo -e `df -h` >> $INFOFILE
echo -e "\n\n" >> $INFOFILE

echo -e "mount output: \n" >> $INFOFILE
echo -e `mount` >> $INFOFILE
echo -e "\n\n" >> $INFOFILE


echo -e "fdisk -l output: \n" >> $INFOFILE
echo -e `fdisk -l` >> $INFOFILE
echo -e "\n\n" >> $INFOFILE

echo -e "dpkg -l output: \n" >> $INFOFILE
echo -e `dpkg -l` >> $INFOFILE
echo -e "\n\n" >> $INFOFILE

echo -e "crontab -l output: \n" >> $INFOFILE
echo -e `crontab -l` >> $INFOFILE
echo -e "\n\n" >> $INFOFILE


tar pPcfz $SSTATEGZIP $INFOFILE $EETARGETS
echo "tar creation of SSTATEGZIP returned: $?" > $LOGFILE


# Generate the SQL dump files that are essentially backups of Atlassian dbs & build gnu tarballs:

mysqldump -u jira --password=$ATLPWD jira > $DUMPFILE; echo "Jira DB Dump returned: $?" >> $LOGFILE
tar pPcfz $JIRAGZIP $DUMPFILE; echo "tar gz call for Jira DB returned: $?" >> $LOGFILE


mysqldump -u jira --password=$ATLPWD confluence > $DUMPFILE; echo "Confl DB Dump returned: $?" >> $LOGFILE
tar pPcfz $CONFLGZIP $DUMPFILE; echo "tar gz call for Confl DB returned: $?" >> $LOGFILE

mysqldump -u jira --password=$ATLPWD bamboo  > $DUMPFILE; echo "Bamboo DB Dump returned: $?" >> $LOGFILE
tar pPcfz $BAMBOOGZIP $DUMPFILE; echo "tar gz call for Bamboo DB returned: $?" >> $LOGFILE


# segregate the gnu tarball files from others in BKUP_DIR...:

if [ "$1"  == "monthly" ]; then
  cp $SSTATEGZIP $GZIP_DIR/monthly_sstate.gz
  cp $JIRAGZIP $GZIP_DIR/monthly_jira.gz
  cp $CONFLGZIP $GZIP_DIR/monthly_confl.gz
  cp $BAMBOOGZIP $GZIP_DIR/monthly_bamboo.gz
elif [ "$1" == "weekly" ]; then
  cp $SSTATEGZIP $GZIP_DIR/weekly_sstate.gz
  cp $JIRAGZIP $GZIP_DIR/weekly_jira.gz
  cp $CONFLGZIP $GZIP_DIR/weekly_confl.gz
  cp $BAMBOOGZIP $GZIP_DIR/weekly_bamboo.gz
else
  cp $SSTATEGZIP $GZIP_DIR/nightly_sstate.gz
  cp $JIRAGZIP $GZIP_DIR/nightly_jira.gz
  cp $CONFLGZIP $GZIP_DIR/nightly_confl.gz
  cp $BAMBOOGZIP $GZIP_DIR/nightly_bamboo.gz
fi

# ... and push the tarballs to EE's Amazon s3 bucket:
s3cmd sync $GZIP_DIR s3://$S3BUCKET; echo "HostConfig push to S3 returned: $?" >> $LOGFILE


# Prune old tarball (note: s3cmd sync will take care of the s3 bucket) and other bkup files:
find $BKUP_DIR -mtime +$PRUNELENGTH -type f -exec rm {} \;
find $GZIPP_DIR -mtime +$PRUNELENGTH -type f -exec rm {} \;

# log status:
echo "Pruning find call returned: $?" >> $LOGFILE

# Email a status report to interested parties:




# END
