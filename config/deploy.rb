require 'mongrel_cluster/recipes'

set :application, "lpirate"
set :scm, "git"
set :repository,  "git@github.com:yjcqwliu/lpirate.git"
set :branch, "master"
set :user, "lpirate"
set :use_sudo, false
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "58.215.65.224"
role :web, "58.215.65.224"
role :db,  "58.215.65.224", :primary => true

task :after_update_code do 
  run "cp #{current_release}/config/database.yml.production #{current_release}/config/database.yml"
  run "cp #{current_release}/config/xiaonei.yml.production #{current_release}/config/xiaonei.yml"
end
