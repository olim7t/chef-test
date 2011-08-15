include_recipe "mysql::server"

database_already_exists = "test -d #{node[:mysql][:data_dir]}/sonar"

# Setup sonar user
grants_path = "/opt/sonar/extras/database/mysql/create_database.sql"

template "/opt/sonar/extras/database/mysql/create_database.sql" do
  not_if database_already_exists
  path grants_path
  source "create_mysql_database.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  action :create
end

execute "mysql-install-application-privileges" do
  not_if database_already_exists
  command "/usr/bin/mysql -u root #{node[:mysql][:server_root_password].empty? ? '' : '-p' }#{node[:mysql][:server_root_password]} < #{grants_path}"
end

# Create database with mysql LWRP
#mysql_database "sonar" do
#  host "localhost"
#  username "root"
#  password node[:mysql][:server_root_password]
#  database "sonar"
#  action :create_db
#end
