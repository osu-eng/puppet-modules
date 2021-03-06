# puppet-sysctl

## Overview

Manage sysctl variable values. All changes are immediately applied, as well as
configured to become persistent. Tested on Red Hat Enterprise Linux 6.

 * `sysctl` : Definition to manage sysctl variables by setting a value.
 * `sysctl::base` : Base class, included from the main definition.

For persistence to work, your Operating System needs to support looking for
sysctl configuration inside `/etc/sysctl.d/`. When using this module, the
existing content of this directory will be purged, so be careful if you
have already put content there.

Beware also that for the purge to work, you need to either have at least one
sysctl definition call left for the node, or include `sysctl::base` manually.
You can also force a value to `ensure => absent`, which will always work.

For the few original settings in the main `/etc/sysct.conf` file, the value is
replaced so that running `sysctl -p` doesn't revert any change made by puppet.

## Examples

    sysctl { 'net.ipv4.ip_forward': value => '1' }
    sysctl { 'net.core.somaxconn': value => '65536' }

