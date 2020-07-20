FROM fedora:latest

RUN dnf makecache

RUN dnf install -y \
  git \
  gcc \
  fuse3 \
  fuse3-devel \
  python \
  python-pip \
  python-devel \
  psmisc \
  sqlite \
  sqlite-devel

RUN git clone -b release-3.5.0 https://github.com/s3ql/s3ql.git /s3ql-src
WORKDIR /s3ql-src

ENV PATH $PATH:/root/.local/bin

ADD requirements.txt .
RUN pip install --user -r requirements.txt

RUN python setup.py build_cython \
  && python3 setup.py build_ext --inplace \
  && python3 setup.py install --user

WORKDIR /root

RUN rm -rf /s3ql-src
RUN dnf clean all

ADD scripts /bin/s3ql-scripts
ENV PATH /bin/s3ql-scripts:$PATH

ENTRYPOINT exec s3qlw_idle
