class database {
  require web
  require epcis_repo
  # create the mysql server
  class { '::mysql::server':
    root_password => 'rootroot',
  }
  # creates the default user
  mysql::db { 'epcis':
    ensure   => present,
    user     => 'epcis',
    password => 'epcis',
    host     => 'cotagent',
    sql      => '/tmp/epcis_schema.sql',
    require  => File['/tmp/epcis_schema.sql'],
  }
  # sql script to populate de database
  file { "/tmp/epcis_schema.sql":
    ensure => present,
    source => "/tmp/epcis-repository-0.5.0/epcis_schema.sql",
  }
  # creates an user (must be changed)
  mysql_user { 'marcus@cot':
    ensure => 'present',
  }
  # define grants (must be changed)
  mysql_grant { 'marcus@cot/epcis.epcis_schema':
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'epcis.epcis_schema',
    user       => 'marcus@cot',
  }
}
