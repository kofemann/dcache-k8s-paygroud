#!/bin/sh -e

rpm -i https://www.desy.de/~tigran/ca_dCacheORG-3.0-4.noarch.rpm
curl https://raw.githubusercontent.com/kofemann/autoca/v1.0-py2/pyclient/autoca-client -o autoca-client
chmod a+x autoca-client
./autoca-client -n -k userkey.pem -c usercert.pem ${AUTOCA_URL} "Kermit the frog"

# poke automounter
ls /cvmfs/grid.desy.de > /dev/null
ls /cvmfs/grid.cern.ch > /dev/null

# patch tu run as root
cp /cvmfs/grid.desy.de/etc/profile.d/scripts/glite-ui-env-old.sh /tmp/grid-ui-env.sh
sed -i -e '12,17d' /tmp/grid-ui-env.sh
. /tmp/grid-ui-env.sh


export X509_USER_PROXY=user-proxy-$CI_PIPELINE_ID

arcproxy --version
arcproxy -C usercert.pem -K userkey.pem  -T ${X509_CERT_DIR} --vomses=${VOMS_USERCONF} --vomsdir=${X509_VOMS_DIR} --voms=desy
arcproxy -I