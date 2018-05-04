FROM amazonlinux:latest

ARG S3_BUCKET
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

RUN mkdir -p /opt/app
WORKDIR /opt/app

RUN yum update -y && yum install -y \
 python27-pip

RUN pip install --upgrade awscli

COPY requirements.txt .

COPY . .

RUN ./build_lambda.sh
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
RUN aws --region us-east-2 s3 cp /opt/app/build/lambda.zip s3://${S3_BUCKET}/clambda.zip --force
