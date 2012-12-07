class { 'puppet': 
  puppetserver => 'puppet',
}

inlcude puppet::master
