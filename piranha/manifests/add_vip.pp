define piranha::real_server::vip ($ip = $title, $netmask, $interface) {
  network::if::alias { $interface:
    ipaddress => $ip,
    netmask   => $netmask,
    ensure    => up,
  }
}
