# s3ql-docker

An [s3ql](https://github.com/s3ql/s3ql) wrapper as a docker image.

It sets up a container with all the binaries of s3ql on the `PATH`, and is meant for usage as a sidecar for the needs of other containers.

# What?

A quick recap on why you would find this useful follows:

#### My app doesn't support S3 natively, but I really want it to store data on it!

We can use [s3ql](https://github.com/s3ql/s3ql) for this. It is a mature (and, frankly, quite clever) approach to this problem.

I'll let you read more over there, but the general idea is to use a bucket as if it was a raw disk, and instead of writing and reading files
to that bucket, you write "blocks" of the s3ql underlying filesystem.

One big advantage is that to read the last byte of that 1GB file stored on s3, you would only load the last block (by default, last 10mb piece) of it.

It allows random reads and writes, which is the biggest issue with "naive" file-based approaches to the issue.

#### But it's annoying to add s3ql to every single app's environment/image if it needs an S3 backend!

You're totally right! This is actually the reason for this image!

#### Oh, then what's the usage setup?

1. Run this image as a side-container on the same host as the app needing it.
2. Use a shared docker volume
3. Pass S3 credentials and start this image

Voilà! Suddenly your other app just sees a folder, unaware that it's S3-backed, and it doesn't need to know.

# Example usage

[tbd]
