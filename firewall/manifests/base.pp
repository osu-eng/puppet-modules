class firewall::base {
  firewall::rule { 'accept-established-related':
    weight => 010,
    rule   => '-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT',
  }

  firewall::rule { 'drop-timestamp-request':
    weight => 020,
    rule   => '-A INPUT -p icmp --icmp-type timestamp-request -j DROP',
  }

  firewall::rule { 'drop-timestamp-reply':
    weight => 030,
    rule   => '-A INPUT -p icmp --icmp-type timestamp-reply -j DROP',
  }

  firewall::rule { 'accept-icmp':
    weight => 040,
    rule   => '-A INPUT -p icmp -j ACCEPT',
  }

  firewall::rule { 'accpt-lo':
    weight => 050,
    rule   => '-A INPUT -i lo -j ACCEPT',
  }

  firewall::rule { 'reject-host-prohibited-input':
    weight => 990,
    rule   => '-A INPUT -j REJECT --reject-with icmp-host-prohibited',
  }

  firewall::rule { 'reject-host-prohibited-forward':
    weight => 995,
    rule   => '-A FORWARD -j REJECT --reject-with icmp-host-prohibited',
  }
}
