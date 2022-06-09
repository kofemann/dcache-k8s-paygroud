FROM centos:7

ENV DCACHE_VERSION=8.1.0-1
ENV DNL_URL=https://www.dcache.org/old/downloads/1.9/repo/8.1/

RUN yum install -y curl

RUN curl --silent -L -O ${DNL_URL}/dcache-${DCACHE_VERSION}.noarch.rpm
RUN curl --silent -L -O https://www.desy.de/~tigran/ca_dCacheORG-3.0-4.noarch.rpm

RUN yum localinstall -y ./dcache-${DCACHE_VERSION}.noarch.rpm
RUN yum localinstall -y ./ca_dCacheORG-3.0-4.noarch.rpm

RUN rm ca_dCacheORG-3.0-4.noarch.rpm dcache-${DCACHE_VERSION}.noarch.rpm

COPY dcache.conf /etc/dcache/dcache.conf
COPY k8s.conf /etc/dcache/layouts/k8s.conf

## fake systemd
RUN yum install -y python3 python36-urllib3 python36-requests
#RUN curl --silent -L -O https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py
RUN curl --silent -L -O https://raw.githubusercontent.com/kofemann/docker-systemctl-replacement/master/files/docker/systemctl3.py
RUN chmod +x ./systemctl3.py && mv ./systemctl3.py /usr/bin/systemctl

RUN yum clean all && rm -rf /var/lib/rpm

RUN curl --silent https://raw.githubusercontent.com/kofemann/autoca/v1.0-py3/pyclient/autoca-client -o autoca-client && chmod a+x autoca-client

COPY run.sh /run.sh
RUN chmod +x /run.sh

RUN chown dcache:dcache /mnt

CMD ["/run.sh"]


