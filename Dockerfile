FROM ubuntu:14.04
MAINTAINER Ruke <rukechen@qnap.com>

RUN apt-get update && \
     apt-get install -y --no-install-recommends wget libssl-dev zlib1g-dev libreadline6-dev build-essential && \
      apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
                            /usr/share/man /usr/share/groff /usr/share/info \
                            /usr/share/lintian /usr/share/linda /var/cache/man && \
    (( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
    (( find /usr/share/doc -empty|xargs rmdir || true ))



COPY Python-2.7.14.tgz /tmp/

RUN cd /tmp && tar -zxf Python-2.7.14.tgz && \
    cd Python-2.7.14 && \
    ./configure --enable-optimizations --enable-unicode=ucs4 && \
    make -j4 && \
    make install

RUN cd /tmp/ && wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py && \
    /usr/local/bin/python2.7 get-pip.py

RUN pip install -v simplejson==3.10.0 salt

RUN rm -rf /tmp/*




