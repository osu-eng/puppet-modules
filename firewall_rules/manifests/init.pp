class firewall_rules {
  include firewall_rules::post

  Firewall {
    require => undef,
  }

  # Clear firewall rules not managed by puppet
  resources { 'firewall':
    purge => true
  }

  # Default firewall rules
  firewall { '000 accept related established rules':
    proto  => 'all',
    state  => [ 'RELATED', 'ESTABLISHED' ],
    action => 'accept',
  }->
  firewall { '001 drop icmp timestamp requests':
    proto  => 'icmp',
    icmp   => 'timestamp-request',
    action => 'drop',
  }->
  firewall { '002 drop icmp timestamp replies':
    proto  => 'icmp',
    icmp   => 'timestamp-reply',
    action => 'drop',
  }->
  firewall { '003 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }->
  firewall { '004 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }
}
