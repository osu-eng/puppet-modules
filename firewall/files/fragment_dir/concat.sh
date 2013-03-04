#!/bin/bash

# First argument ($1): firewall configuration directory

# Start the rules file
cat $1/global-pre > $1/firewall-rules.new

# Concatenate the mangle table fragments
cat $1/mangle-pre >> $1/firewall-rules.new
for FRAGMENT in `ls $1/mangle`; do
  cat $1/mangle/$FRAGMENT >> $1/firewall-rules.new
done
cat $1/mangle-post >> $1/firewall-rules.new

# Concatenate the filter table fragments
cat $1/filter-pre >> $1/firewall-rules.new
for FRAGMENT in `ls $1/filter`; do
  cat $1/filter/$FRAGMENT >> $1/firewall-rules.new
done
cat $1/filter-post >> $1/firewall-rules.new

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
