include_recipe "backup"
include_recipe "aws"

aws = data_bag_item("aws", "main")

search(:apps) do |app|
  (app['database_master_role'] & node.run_list.roles).each do |dbm_role|
      end
end


backup_model "bamboo" do
  description "Back up my database"

  definition <<-EOH
    split_into_chunks_of 2048

    database MySQL do |db|
      db.name = '#{node['db']['name']}'
      db.username = '#{node['db']['username']}'
      db.password = '#{node['db']['password']}'
    end

    compress_with Gzip

    store_with S3 do |s3|
      s3.access_key_id = '#{aws['aws_access_key_id']}'
      s3.secret_access_key = '#{aws['aws_secret_access_key']}'
      s3.bucket = '#{aws['backup_bucket']}'
      s3.path = '#{aws['backup_path']}' + "/" + '#{node.name}'
    end
  EOH

  mailto "jgerrish@eartheconomics.org"
  action :create  
end
