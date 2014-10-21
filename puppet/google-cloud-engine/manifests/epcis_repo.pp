class epcis_repo {
  # before perform the epcis repository setup the apache-tomcat module is required
  require web
  # download the epcis repository
  exec { 'epcis-download':
    command => 'wget https://oss.sonatype.org/content/repositories/public/org/fosstrak/epcis/epcis-repository/0.5.0/epcis-repository-0.5.0-bin-with-dependencies.zip -O /tmp/epcis.zip',
    unless  => 'which epcis-repositry-0.5.0',
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
}
