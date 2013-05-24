#!/bin/zsh
/usr/bin/vagrant destroy --force
yes | knife client delete ziggurat-dev
yes | knife node delete ziggurat-dev
/usr/bin/vagrant up
knife bootstrap localhost --node-name ziggurat-dev --ssh-user vagrant --ssh-password vagrant --ssh-port 2222 --sudo
/usr/bin/vagrant provision
