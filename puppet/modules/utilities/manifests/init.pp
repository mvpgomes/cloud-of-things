class utilities {
  # install the unzip package
  package { 'unzip':
    ensure => installed,
    require => Exec['apt-get update']
  }
}
