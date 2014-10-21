# /etc/puppet/manifests/agent.pp
# ------------------------------------
# the puppet-agent instance
# ------------------------------------
gce_instance { 'cotagent':
  ensure         => present,
  zone           => 'europe-west1-b',
  machine_type   => 'g1-small',
  network        => 'default',
  image          => 'projects/debian-cloud/global/images/backports-debian-7-wheezy-v20141017',
  startupscript  => 'pe-simplified-agent.sh',
  metadata       => {
    'pe_role'    => 'agent',
    'pe_master'  => 'cotmaster',
    'pe_version' => '3.3.1',
  },
  tags           => ['puppet', 'pe-agent'],
}

gce_firewall { 'allow-http':
  ensure      => present,
  network     => 'default',
  description => 'Allow incoming http connections.',
  allowed     => 'tcp:80'
}

gce_httphealthcheck { 'basic-http':
  ensure  => present,
  require => Gce_instance['cotagent'],
  description  => 'basic http health check',
}

gce_targetpool { 'web-pool':
    ensure        => present,
    require       => Gce_httphealthcheck['basic-http'],
    health_checks => 'basic-http',
    instances     => 'europe-west1-b/web1,europe-west1-a/web2',
    region        => 'europe-west1',
}

gce_forwardingrule { 'web-rule':
    ensure       => present,
    require      => Gce_targetpool['web-pool'],
    description  => 'Forward HTTP to web instances',
    port_range   => '80',
    region       => 'europe-west1',
    target       => 'web-pool',
}
