include network

# normal interface - bootp
network::if::dynamic { "eth99":
  macaddress   => "ef:ef:ef:ef:ef:ef",
  bootproto    => "bootp",
  mtu          => "1500",
  ethtool_opts => "speed 100 duplex full autoneg off",
  ensure       => "up",
}

