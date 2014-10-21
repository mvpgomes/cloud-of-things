# /etc/puppet/manifests/gce.pp
# -------------------------------------
# the puppet-master instance
# -------------------------------------
gce_instance { 'cotmaster':
  ensure                => present,
  description           => 'A Puppet Enterprise Master and Console',
  machine_type          => 'n1-standard-1',
  zone                  => 'europe-west1-b',
  network               => 'default',
  tags                  => ['puppet', 'master', 'http-server', 'https-server'],
  image                 => 'projects/debian-cloud/global/images/backports-debian-7-wheezy-v20140924',
  startupscript         => 'puppet-enterprise.sh',
  metadata             => {
    'pe_role'          => 'master',
    'pe_version'       => '3.3.1',
    'pe_consoleadmin'  => 'admin@cot.com',
    'pe_consolepwd'    => 'puppetize',
  },
  module_repos         => {
      'gce_compute'    => 'git://github.com/puppetlabs/puppetlabs-gce_compute',
      'java'           => 'git://github.com/puppetlabs/puppetlabs-java',
      'tomcat'         => 'git://github.com/puppetlabs/puppetlabs-tomcat',
      'mysql'          => 'git://github.com/puppetlabs/puppetlabs-mysql',
      'epel'           => 'git://github.com/stahnma/puppet-module-epel'
  },
  service_account_scopes => ['compute-ro'],
}
