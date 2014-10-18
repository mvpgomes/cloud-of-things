# /etc/puppet/manifests/agent.pp
# ------------------------------------
# the puppet-agent instance
# ------------------------------------
gce_instance { 'agent':
  ensure         => present,
  zone           => 'europe-west1-b',
  machine_type   => 'g1-small',
  network        => 'default',
  image          => 'projects/debian-cloud/global/images/backports-debian-7-wheezy-v20140924',
  startupscript  => 'pe-simplified-agent.sh',
  metadata       => {
    'pe_role'    => 'agent',
    'pe_master'  => 'master',
    'pe_version' => '3.3.1',
  },
  tags           => ['puppet', 'pe-agent', 'http-server', 'https-server'],
}
