class 'web' {
  class { 'java': }
  class { 'tomcat': }
  #tomcat::instance { 'tomcat8':
  #	catalina_base => '/opt/apache-tomcat/tomcat8',
  #	source_url    => 'http://mirror.nexcess.net/apache/tomcat/tomcat-8/v8.0.14/bin/apache-tomcat-8.0.14.tar.gz'
  #}->
  #tomcat::service { 'default':
  #	catalina_base => '/opt/apache-tomcat/tomcat8',
  #}
  class { '::mysql::server': }
}
