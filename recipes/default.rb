#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (C) 2014
#
#
#
package "httpd" do
  action :install
end

service "httpd" do
  action [:start, :enable]
end

template "/var/www/html/index.html" do
  source "index.html.erb"
end

# disable the default home page
execute "mv /etc/httpd/conf.d/welcome.conf{,.disabled}" do
  only_if do
    File.exist?("/etc/httpd/conf.d/welcome.conf")
  end
  notifies :restart, "service[httpd]"
end

# disable the default home page
# if File.exist?("/etc/http/conf.d/welcome.conf") do
#   execute "mv /etc/httpd/conf.d/welcome.conf{,.disabled}" do
#     notifies :restart, "service[httpd]"
#   end
# end

# loop over my apache sites
node["apache"]["sites"].each do |site_name, site_data|
  #   set document root
  document_root = "/srv/apache/#{site_name}"
  # document_root = '/srv/apache/' + site_name

  #   write conf file
  template "/etc/httpd/conf.d/#{site_name}.conf" do
    source "custom.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => site_data["port"]
    )
  end

  #   create the document root directory
  directory document_root do
    mode      "0755"
    action    :create
    recursive true
  end

  #   write the home page
  template "#{document_root}/index.html" do
    source "index.html.erb"
    mode   "0644"
    variables(
      :site_name => site_name,
      :port      => site_data["port"]
    )
  end
end
