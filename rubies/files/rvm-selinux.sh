#!/bin/bash

chcon -R --type=httpd_sys_content_t /usr/loca/rvm
semanage fcontext -a -t httpd_sys_content_t /usr/local/rvm
