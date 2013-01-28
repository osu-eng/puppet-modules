#!/bin/bash

# First argument ($1): firewall configuration directory

# Concatenate the fragments
cat $1/firewall-pre > $1/firewall-rules.new
for FRAGMENT in `ls $1/fragments`; do
  cat $1/fragments/$FRAGMENT >> $1/firewall-rules.new
done
cat $1/firewall-post >> $1/firewall-rules.new

iptables-restore --test < $1/firewall-rules.new
if [ $? -ne 0 ]
then
  rm -f $1/firewall-rules.new
  exit 1
else
  cat $1/firewall-rules.new > $1/firewall-rules
  rm -f $1/firewall-rules.new
  exit 0
fi
