chcon -R --type=httpd_sys_content_t /var/aegir
chcon -R --type=var_t /var/aegir/.ssh
chcon -R --type=httpd_config_t /var/aegir/config
chcon -v --type=ssh_home_t /var/aegir/.ssh/authorized_keys
semanage fcontext -a -t httpd_sys_content_t /var/aegir
semanage fcontext -a -t var_t /var/aegir/.ssh
semanage fcontext -a -t httpd_config_t /var/aegir/config
semanage fcontext -a -t ssh_home_t /var/aegir/.ssh/authorized_keys
