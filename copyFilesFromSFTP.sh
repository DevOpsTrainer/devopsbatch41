Remote server connection script
ftp_host=$1
ftp_user=$2
password=$3
src_dir=$4
tgt_dir=$5
file_name=$6
#################################################################################
#     Get the files(file_name) from  SFTP                 						#
#################################################################################

#!/usr/bin/expect
echo "The  Batch Job has started at `date +%Y-%m-%d_%H:%M:%S`"
set timeout -1
expect   <<END_SCRIPT
spawn sftp -oPort=22  ${ftp_user}@${ftp_host}
#expect -ex  "password:";
#send "${password}\n";
expect -ex   "sftp>";
send "mget ${src_dir}${file_name} ${tgt_dir}\n"
expect -ex   "sftp>";
#sleep 60
send "bye\n"
exit 0
END_SCRIPT
echo "The  Batch Job has Ended getting files from sftp at `date +%Y-%m-%d_%H:%M:%S`"

