name             "development"
maintainer       "YOUR_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures development"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.3"

depends "rbenv", "1.4.1"
depends "postgresql", "2.0.2"
depends "database", "1.3.4"
