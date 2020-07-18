FROM fedora:latest

RUN dnf makecache

RUN dnf install -y \
  fuse3 \
  fuse3-devel \
  python \
  python-devel \
  python-virtualenv \
  sqlite \
  sqlite-devel

RUN build-s3ql.sh
