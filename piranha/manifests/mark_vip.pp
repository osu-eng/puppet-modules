define piranha::markvip ($ip = $title, $netmask, $interface) {
  firewall::rule { "bundle-http-https-${ip}":
    weight => '110',
    table  => 'mangle',
    rule   => "-A PREROUTING -p tcp -d ${ip}/32 -m multiport --dports 80,443 -j MARK --set-mark 80",
  }
}
