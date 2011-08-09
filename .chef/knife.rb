log_level                :info
log_location             STDOUT
node_name                'olim7t'
client_key               '/home/olim7t/chef-repo/.chef/olim7t.pem'
validation_client_name   'chef-validator'
validation_key           '/etc/chef/validation.pem'
chef_server_url          'none'
cache_type               'BasicFile'
cache_options( :path => '/home/olim7t/chef-repo/.chef/checksums' )
cookbook_path [ '/home/olim7t/chef-repo/cookbooks', '/home/olim7t/chef-repo/site-cookbooks' ]
