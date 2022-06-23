#!/bin/sh


if [ x$1 != x ]
then
  python3 /autoca-client -n -k /etc/grid-security/hostkey.pem -c /etc/grid-security/hostcer.pem ${AUTOCA_URL} $1
  chown dcache:dcache /etc/grid-security/hostkey.pem  /etc/grid-security/hostcer.pem
fi

if [ ! -f /.init_complete ]
then
  for f in `ls /dcache.init.d`
  do
    . /dcache.init.d/$f
  done
  touch /.init_complete
fi

systemctl daemon-reload
systemctl list-dependencies dcache.target
systemctl start dcache.target
systemctl log -f  dcache@*

