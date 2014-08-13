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
