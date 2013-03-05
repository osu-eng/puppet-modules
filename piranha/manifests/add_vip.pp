define piranha::add_vip ($ip = $title, $netmask, $interface) {
  include rclocal

  rclocal::script { "piranha-persist-${ip}":
    priority => '10',
    content  => "ip addr add ${ip} dev ${interface} \n",
  }
}
