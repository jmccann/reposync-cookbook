name             'reposync'
maintainer       'Jacob McCann'
maintainer_email 'jacob.mccann2@target.com'
license          'all_rights'
description      'Installs/Configures reposync'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'yum-centos'
depends 'yum-epel'

depends 'nginx', '~> 2.7.6'
