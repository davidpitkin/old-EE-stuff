# cookbooks/atlassian-backup/recipes/default.rb
#
# Cookbook Name:: atlassian-backup
# Recipe:: default
#
# Copyright 2013, Virtual Systems Administrators, LLC
#
# All rights reserved - Do Not Redistribute
#
#  Note: you may need to alter files in cookbooks/atlassian-backup/files/default 
#    to match your confluence and jira dbs, usernames, and passwords.
#    Also, remember to set things like BKUP_DIR, GZIP_DIR, ATLPWD, S3BUCKET, PRUNELENGTH,  
#    and .s3cfg appropriately 

# Preamble
known_s3tools_checksum = node["s3tools"]["checksum"]
curr_s3tools_checksum = "curl -L -s http://s3tools.org/repo/deb-all/stable/s3tools.key | shasum -a 256 | cut -c-12"
known_s3tools_vers = node["s3tools"]["version"]

# This doesn't really check against actual most recent version
#if {::File.exists?("/usr/bin/s3cmd)"}
#  curr_s3tools_vers = "/usr/bin/s3cmd --version | cut -d ' ' -f 3
#else
#  curr_s3tools_vers = "nil"
#fi


#  Add the needed Amazon S3 packages...
#    sudo wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | sudo apt-key add -
#    sudo wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list
execute "add Amazon S3 packages" do
  command "touch #{Chef::Config[:file_cache_path]}/s3tools"
  command "sudo wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | sudo apt-key add -"
  command "sudo wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list"
  not_if {curr_s3tools_checksum == known_s3tools_checksum} && not_if {::File.exists?("#{Chef::Config[:file_cache_path]}/s3tools")}
end


#  Refresh package cache and install the newest s3cmd: 
#    sudo apt-get update && sudo apt-get install s3cmd
execute " Refresh package cache, install " do
  command "sudo apt-get update && sudo apt-get install s3cmd"
  not_if {curr_s3tools_checksum == known_s3tools_checksum}
end

#  Place S3 configuration file.
cookbook_file "/root/.s3cfg" do
  source ".s3cfg"
  owner "root"
  group "root"
  mode "0600"
end

#  Place the backup script
cookbook_file "/usr/local/bin/data_bkup.sh" do
  source "data_bkup.sh"
  owner "root"
  group "root"
  mode "0755"
end

#  Add appropriate entries to root's crontab for nightly, weekly, monthly job runs.
# 00 22 * * 1-6 /usr/local/bin/data_bkup.sh > /dev/null
# 00 02 * * 0 /usr/local/bin/data_bkup.sh weekly > /dev/null
# 00 04 1 * * /usr/local/bin/data_bkup.sh monthly > /dev/null
cron "nightly atlassian backup run" do
  minute "00"
  hour "22"
  weekday "1-6"
  command "/usr/local/bin/data_bkup.sh > /dev/null"
end
cron "weekly atlassian backup run" do
  minute "00"
  hour "22"
  weekday "0"
  command "/usr/local/bin/data_bkup.sh > /dev/null"
end
cron "monthly atlassian backup run" do
  minute "00"
  hour "22"
  day "1"
  command "/usr/local/bin/data_bkup.sh > /dev/null"
end
