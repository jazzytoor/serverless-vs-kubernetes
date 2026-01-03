FROM --platform=linux/x86_64 public.ecr.aws/lambda/python:3.9

# ensure libs are up to date
RUN : \
    && yum -y update --security \
    && yum clean all \
    && rm -rf /var/cache/yum \
    :

WORKDIR ${LAMBDA_TASK_ROOT}
COPY app ${LAMBDA_TASK_ROOT}

RUN : \
    && python3.9 -m pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}" \
    &&:

CMD ["main.lambda_handler"]
