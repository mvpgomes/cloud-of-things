Cloud Of Things
===============

Cloud of Things is an infrastructure framework that provides storage and maintenance over
the objects that are present in a specific physical space.

The detailed instructions for installation and configuration of Cloud Of Things will be
covered in the next sections.

##PREREQUISITES
To deploy an instance of Cloud Of Things you need to have a cloud computing platform enabled,
like Google Compute Engine, Amazon Web Services, VMware and to have Puppet Enterprise installed.

##Google Compute Engine
To perform cloud provisioning with Google Cloud Engine, you need a Google Account and a Compute
Engine project enabled.

1. **Create Google Account**

  If you don't already have an account, you can
  [create a new Google Account](https://accounts.google.com/SignUp).

2. **Create Compute Engine Project**

  To create a Compute Engine project, first you need to login with your account at
  [Google Developers Console](https://console.developers.google.com/), and then create a new
  project and enable billing.

3. **Enable Google Compute API**

  After you create the Compute Engine project, you need to enable Google Compute Engine API.
  To enable the API, click on the created project and then in the left panel expand the **API & auth**
  section. Then click on **APIs** and activate Google Compute Engine.

4. **Install Google Cloud SDK**

  Download and install the [Google Cloud SDK](https://cloud.google.com/compute/docs/gcloud-compute/).
  After the installation is completed authenticate to Google Cloud Platform by running in your terminal
  the command `gcloud auth login`.

##Amazon Web Services

##VMware

##Puppet
Puppet is configuration management system that allows you to define the state of your IT
infrastructure, then automatically enforce the correct state.

Puppet automates every step of the software delivery process: from provisioning of physical
and virtual machines to orchestration and reporting; from early-stage code development through
testing, production release and updates. Puppet ensures consistency, reliability and stability

To get started with puppet, you need to install Puppet in your workstation. If are running Debian
or Ubuntu you just need to run in your terminal `apt-get install puppet`, for other OS's please
refer to [Installing Puppet: Pre-Install Tasks](https://docs.puppetlabs.com/guides/install_puppet/pre_install.html).

#Setup
Now that you have you local workstation configured, we can now setup our local Puppet Environment. In the next sections
we will describe how to setup your local Puppet environment regarding on the Cloud Provisioning Service that is used to
deploy the Cloud Of Things instances.

##Google Cloud Engine
Puppet Enterprise already comes integrated with GCE. To setup you local Puppet environment with GCE, first you need to install
the Google Compute Engine Module from PuppetLabs running in your terminal:

    puppet module install puppetlabs-gce_compute

Then create a `device.conf` in your Puppet configuration path. To determine the location of the file run the following command:

    puppet apply --configprint deviceconfig

This command should give an output like `/etc/puppet/device.conf` or `~/.puppet/device.conf`. Go to this directory and open the
file `device.conf`, the file should look like this:

    #/etc/puppet/device.conf
    [my_project]
      type gce
      url [/dev/null]:project_id

In the section header `my_project` you can choose any name associated with your project. This is the name of the certificate and
will be used in the future to select the right project when connecting to GCE.

Within the element url just change `project_id` to your Project ID that is assigned to your GCE project. To check you Project ID,
go to [Google Developers Console](https://console.developers.google.com/) and at in the project overview section you can see on the
top of the screen your `Project ID` and `Project Number`.

###Puppet Master
The Puppet Master will be the management server for all our instances with the running Puppet agents and should therefore be reachable
from the instances over the network. Every Puppet agent polls the configuration from the master and start running if it compilation
succeeded. The Puppet Master machine type should be chosen regarding the number of agents that will be deployed. The available machine types
provided by Google Compute Engine are described [here](https://cloud.google.com/compute/docs/machine-types).

Now its time to create the manifest to the Puppet Master, the manifest can be found at `/puppet/google-cloud-engine/manifests/master.pp`.
Now we can create and start our Puppet Master executing the following command:

    puppet apply --certname cloud-of-things master.pp

Depending on the machine type that you choose, the installation could take a few minutes, if everything went fine you should see a message like
this in your Puppet Master instance console log at Google Developer Console.

    Cenas.

Now you can **ssh** to your new created instance executing:

    gcutil ssh puppet-master
