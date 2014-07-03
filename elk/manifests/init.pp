class elk {
  include apache

  class { 'elasticsearch':
    manage_repo  => true,
    repo_version => '1.2',
    version => '1.2.1-1',
    java_install => true
  }

  elasticsearch::instance { 'es-01': }

  class { 'logstash':
    package_url => 'https://download.elasticsearch.org/logstash/logstash/packages/centos/logstash-1.4.2-1_2c0f5a1.noarch.rpm',
    install_contrib => true,
    contrib_package_url => 'https://download.elasticsearch.org/logstash/logstash/packages/centos/logstash-contrib-1.4.2-1_efd53ef.noarch.rpm'
  }

  logstash::configfile { 'configname':
  	source => 'puppet:///modules/elk/logstash.conf'
  }
}
