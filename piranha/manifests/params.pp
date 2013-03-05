class piranha::params {
  $repo_url = "http://example.com/repo"
  $virtual_ip = { '192.168.56.200' => { netmask => '255.255.255.0', interface => 'eth0:1' } }
  $service_port = [ '80', '443' ]
  $gui_password = ".x0MxPyN/65DU"
  $lvs_config = "
serial_no = 1
primary = ${ipaddress}
service = lvs"
}
