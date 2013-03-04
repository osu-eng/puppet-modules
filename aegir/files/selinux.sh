chcon -R --type=httpd_sys_content_t /var/aegir
chcon -R --type=httpd_config_t /var/aegir/config
semanage fcontext -a -t httpd_sys_content_t /var/aegir
semanage fcontext -a -t httpd_config_t /var/aegir/config
