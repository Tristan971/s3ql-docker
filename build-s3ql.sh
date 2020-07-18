#!/usr/bin/env bash

source s3ql.env

git clone "$S3QL_REMOTE" s3ql
cd s3ql || exit 1

git checkout "$S3QL_REF"
virtualenv ./venv

pip install -r ../requirements.txt

python3 setup.py build_cython
python3 setup.py build_ext --inplace
