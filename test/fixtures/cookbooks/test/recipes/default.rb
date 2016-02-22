reposync_mirror 'centos-el7-base' do
  path 'latest/centos/el7'
  yum_repo 'base' do
    mirrorlist 'http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=os'
    gpgkey 'http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7'
  end
end
