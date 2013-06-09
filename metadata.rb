name             "development"
maintainer       "YOUR_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures development"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.3"

depends "ubuntu"
depends "apt"
depends "sudo"

depends "golang"
depends "postgresql-src"

# depends "rbenv"

# depends "postgresql"
# depends "database"
# depends "java"
# depends "elasticsearch"

