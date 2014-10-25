class epcis {
  # before perform the epcis repository setup the apache-tomcat module is required
  require web
  require utilities
  # download the epcis repository
  exec { 'epcis-download':
    command => 'wget https://oss.sonatype.org/content/repositories/public/org/fosstrak/epcis/epcis-repository/0.5.0/epcis-repository-0.5.0-bin-with-dependencies.zip -O /tmp/epcis.zip',
    unless  => '[ -d /tmp/epcis-repository-0.5.0 ]',
    path    => ['/bin', '/usr/bin'],
    notify  => Exec['epcis-unpack'],
  }
  # unzip the epcis repository
  exec { 'epcis-unpack':
    command     => 'unzip epcis.zip',
    cwd         => '/tmp',
    path        => ['/bin', '/usr/bin'],
    refreshonly => true,
    require     => Exec['epcis-download'],
  }
  # place the WAR file at the tomcat webapp directory
  exec { 'place-war':
    command => 'cp /tmp/epcis-repository-0.5.0/epcis-repository-0.5.0.war /var/lib/tomcat7/webapps',
    path    => ['/bin', '/usr/bin'],
    require => Exec['epcis-unpack'],
  }
  # configure the the repository to connect with the database
  file { '/etc/tomcat7/Catalina/localhost/epcis-repository-0.5.0.xml':
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/epcis/epcis-repository-0.5.0.xml',
  }
}
