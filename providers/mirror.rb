action :create do
  directory '/etc/reposync/conf.d' do
    recursive true
  end

  cookbook_file '/etc/reposync/repograb.sh' do
    cookbook 'reposync'
    mode '0750'
  end

  template "/etc/reposync/conf.d/#{new_resource.name}.repo" do
    if new_resource.yum_repo.source.nil?
      source 'repo.erb'
      cookbook 'yum'
    else
      source new_resource.yum_repo.source
    end
    mode new_resource.yum_repo.mode
    sensitive new_resource.yum_repo.sensitive
    variables(config: new_resource.yum_repo)
  end

  cron "reposync_mirror #{new_resource.name} cron" do
    command "/etc/reposync/repograb.sh /etc/reposync/conf.d/#{new_resource.name}.repo #{new_resource.webroot}/#{new_resource.path}"
    minute '0'
    hour '20'
    day '*'
  end
end
