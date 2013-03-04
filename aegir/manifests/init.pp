class aegir (
  
  # If you want to override users
  $user_id = $aegir::params::user_id,
  $user_name = $aegir::params::user_name,
  
  # If you want to override group
  $group_id = $aegir::params::group_id,
  $group_name = $aegir::params::group_name,
  
  # If you want to override home
  $home = $aegir::params::home,
  
  # Aegir keys
  $private_key_source = hiera('aegir::private_key_source', $aegir::params::private_key_source),
  $public_key_source = hiera('aegir::public_key_source', $aegir::params::public_key_source),
  $authorized_keys = hiera('aegir::authorized_keys', $aegir::params::authorized_keys),
  
  # Apache options
  $apache_group_name = $aegir::params::apache_group_name,
  
) inherits aegir::params {

  include sudo
    
  user {$user_name:
    comment    => 'User for the Aegir Hosting System',
    home       => '/var/aegir',
    shell      => '/bin/bash',
    uid        => $user_id,
    gid        => $group_id,
    groups     => [$apache_group_name],
    require    => [Group[$group_name]],
  }
  
  group {$group_name:
    gid        => $group_id,
  }
  
  file {$home:
    ensure     => directory,
    owner      => $user_name,
    group      => $group_name,
    mode       => 755,
    require    =>[User[$user_name], Group[$group_name]]
  }
  
  file {"${home}/.ssh":
    ensure     => directory,
    owner      => $user_name,
    group      => $group_name,
    mode       => 700,
    require    => File[$home]
  }
  
  file {"${home}/.ssh/id_rsa":
    ensure     => present,
    owner      => $user_name,
    group      => $group_name,
    mode       => 600,
    source  => "puppet:///private${home}/.ssh/id_rsa",
    require    => File["$home/.ssh"]
  }
  
  file {"${home}/.ssh/id_rsa.pub":
    ensure     => present,
    owner      => $user_name,
    group      => $group_name,
    mode       => 644,
    source  => "puppet:///private${home}/.ssh/id_rsa.pub",
    require    => File["$home/.ssh"]
  }
  
  
  
  # This doesn't seem to be working
  sudo::directive {'aegir_apache_restart':
    ensure     => present,
    content    => "$user_name ALL=(ALL) NOPASSWD: /usr/sbin/apachectl",
    require    => User[$user_name],
  }

  file {'/root/aegir-selinux.sh':
    source => 'puppet:///modules/aegir/selinux.sh',
    mode => '0755',
  }

  exec {'/root/aegir-selinux.output':
    command => '/root/aegir-selinux.sh > /root/aegir-selinux.output',
    require => File['/root/aegir-selinux.sh'] ,
    creates => '/root/aegir-selinux.output'
  }  

  exec { "/bin/ln -s ${home}/config/apache.conf /etc/httpd/conf.d/aegir.conf ; service httpd restart":
    creates => "/etc/httpd/conf.d/aegir.conf",
    onlyif => "/usr/bin/test -f ${home}/config/apache.conf",
  }

  # Various configuration files
  file { "${home}/.ssh/authorized_keys":
    ensure  => present,
    owner      => $user_name,
    group      => $group_name,
    mode    => '0644',
    content => template('aegir/authorized_keys.erb'),
  }
  
}
