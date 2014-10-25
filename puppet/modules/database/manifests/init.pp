# define the variables for the url's and resources !!!
class database {
  require web
  require epcis_repo
  # install mysql-connectorJ
  exec { 'connectorj-download':
    command => 'wget http://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.33/mysql-connector-java-5.1.33.jar -O /tmp/mysql-connector-java-5.1.33.jar',
    unless  => '[ -d /tmp/mysql-connector-java-5.1.33.jar ]',
    path    => ['/bin', '/usr/bin'],
    notify  => Exec['place-connectorj'],
  }
  # place the connectorJ in the tomcat directory
  exec { 'place-connectorj':
    command => 'cp /tmp/mysql-connector-java-5.1.33.jar /usr/share/tomcat7/lib',
    path    => ['/bin', '/usr/bin'],
    refreshonly => true,
    require => Exec['connectorj-download'],
  }
  # create the mysql server
  class { '::mysql::server':
    root_password => 'rootroot',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } },
  }
  # creates the default user
  mysql::db { 'epcis':
    ensure   => present,
    user     => 'epcis',
    password => 'epcis',
    host     => 'localhost',
    sql      => '/tmp/epcis_schema.sql',
    grant    => ['ALL'],
    require  => File['/tmp/epcis_schema.sql'],
  }
  # sql script to populate de database
  file { '/tmp/epcis_schema.sql':
    ensure => present,
    source => "/tmp/epcis-repository-0.5.0/epcis_schema.sql",
  }
}
