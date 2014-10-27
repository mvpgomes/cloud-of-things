class utilities {
  # updates the packages
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }
  # install the unzip package
  package { 'unzip':
    ensure => installed,
    require => Exec['apt-get update']
  }
}
