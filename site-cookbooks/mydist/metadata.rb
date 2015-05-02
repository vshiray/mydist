name             'mydist'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures mydist'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'java'
depends          'mongodb'
depends          'nginx-dist'
depends          'postgresql'
depends          'xvfb'
