Cloud Of Things
===============

Cloud of Things is an infrastructure framework that provides storage and maintenance over
the objects that are present in a specific physical space.

To use this framework is necessary to install some features that are described in the next
sections.

# Chef

Chef requires that you have installed in your workstation the Ruby programming language and **knife**,
the command-line tool that provides the interface between the workstation and the Chef server. The omnibus
installer prepare your workstation for you get started with Chef, to do this run this command from you terminal:

###OS X
    curl -L https://www.opscode.com/chef/install.sh | sudo bash
###Ubuntu
    curl -L https://www.opscode.com/chef/install.sh | sudo bash
###Windows
For Windows the installer is available at http://downloads.getchef.com/.
# Vagrant

To run Vagrant you need to install VirtualBox, to download and install go to https://www.virtualbox.org/wiki/Downloads
and choose your distribution.

To install Vagrant go to https://www.vagrantup.com/downloads.html and choose your distribution.

To enable Vagrant to install Chef Client in your VM you need to install the Vagrant Omnibus
plugin :

    vagrant plugin install vagrant-omnibus
