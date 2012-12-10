class firewall_rules::post {
  firewall { '998 input reject all':
    proto   => 'all',
    action => 'reject',
    reject => 'icmp-host-prohibited',
    before  => undef,
  }
  firewall { '999 fprward reject all':
    proto   => 'all',
    chain  => 'FORWARD',
    action => 'reject',
    reject => 'icmp-host-prohibited',
    before  => undef,
  }
}
