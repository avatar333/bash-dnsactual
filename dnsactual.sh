#!/usr/bin/env bash
#title           :dnsactual.sh
#description     :A script to dynamically update DNS from home
#author		 :Kevin Pillay
#date            :20180625
#version         :0.1    
#usage		 :bash dnsactual.sh
#notes           :
#bash_version    :GNU bash, version 4.4.19(1)-release (x86_64-redhat-linux-gnu)
#==============================================================================

IPFILE=/etc/freedns/dnsactual.dat

if [[ ! -d /etc/freedns ]]
then
  mkdir -p /etc/freedns
fi

if [[ -f $IPFILE ]]
then
  CACHEIP=$(cat $IPFILE)
fi

CURRIP=$(wget http://freedns.afraid.org/dynamic/check.php -o /dev/null -O /dev/stdout | grep Detected | cut -d : -f 2 | cut -d '<' -
f 1 | tr -d " ")
if [ "$CURRIP" = "$CACHEIP" ]
then
  # Both IP are equal
  echo "Update not required..."
else
  # The IP has change
  echo "Updating http://free.afraid.org with " $CurreIP
  wget https://freedns.afraid.org/dynamic/update.php?clNFNUVaNnQ1dGVXMFljRzREZ0o6MjQ3NDUwMg== -o /dev/null -O /dev/stdout
  echo `date`  "Updating log with IP " $CURRIP >> /tmp/$(basename $0).log
fi
rm -f $IPFILE
echo $CURRiP > $IPFILE
