define piranha::add_vip ($ip = $title, $netmask, $interface) {
  include rclocal

  exec { "piranha-add-${ip}":
    provider => shell,
    command  => "/sbin/ip addr add ${ip} dev ${interface}",
    unless   => "/sbin/ip addr | /bin/grep ${ip} 2>/dev/null",
  }

  rclocal::script { "piranha-persist-${ip}":
    priority => '10',
    content  => "ip addr add ${ip} dev ${interface} \n",
    before   => Exec["piranha-add-${ip}"],
  }
}
