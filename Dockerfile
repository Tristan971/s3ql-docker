FROM fedora:latest

RUN dnf install -y \
  git \
  gcc \
  fuse3 \
  fuse3-devel \
  procps-ng \
  python \
  python-pip \
  python-devel \
  psmisc \
  sqlite \
  sqlite-devel \
  && dnf clean all

ADD requirements.txt /requirements.txt
RUN pip install --user -r requirements.txt
ENV PATH /root/.local/bin:$PATH

RUN git clone -b release-3.5.0 https://github.com/s3ql/s3ql.git /s3ql-src \
  && cd /s3ql-src \
  && python setup.py build_cython \
  && python3 setup.py build_ext --inplace \
  && python3 setup.py install --user \
  && cd /root \
  && rm -rf /s3ql-src

ADD scripts /bin/s3ql-scripts
ENV PATH /bin/s3ql-scripts:$PATH

STOPSIGNAL SIGTERM

ENTRYPOINT /bin/s3ql-scripts/s3qlw_idle
