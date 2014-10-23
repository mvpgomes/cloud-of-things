class web {
  # install and deploy the apache-tomcat service
  class { 'java': }
  class { 'tomcat': }
  class { 'epel': }->
  tomcat::instance{ 'default':
    install_from_source => false,
    package_name        => 'tomcat7',
  }->
  tomcat::service { 'default':
    use_jsvc     => false,
    use_init     => true,
    service_name => 'tomcat7',
  }
}
