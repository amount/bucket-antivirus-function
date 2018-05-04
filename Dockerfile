FROM amazonlinux:latest

ARG S3_BUCKET
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

RUN mkdir -p /opt/app
WORKDIR /opt/app

RUN yum update -y && yum install -y \
  cpio \
  python27-pip \
  zip

RUN pip install --upgrade awscli

COPY requirements.txt .
RUN pip install --no-cache-dir virtualenv
RUN virtualenv env
RUN source env/bin/activate
# RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN ./build_lambda.sh
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
RUN aws --region us-east-2 s3 cp /opt/app/build/lambda.zip s3://${S3_BUCKET}/clambda.zip --force
