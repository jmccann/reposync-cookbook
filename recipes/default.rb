#
# Cookbook Name:: reposync
# Recipe:: default
#
# Copyright (c) 2016 Jacob McCann, All Rights Reserved.

include_recipe 'yum-centos::default'
include_recipe 'yum-epel::default'
include_recipe 'nginx::default'

# Override default site template
resources("template[#{node['nginx']['dir']}/sites-available/default]").cookbook 'reposync'

package 'yum-utils'
package 'createrepo'

directory node['nginx']['default_root'] do
  recursive true
end

execute 'reposync -l -g --download-metadata' do
  cwd node['nginx']['default_root']
end
