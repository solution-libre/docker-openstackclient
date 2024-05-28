FROM python:slim

RUN apt-get update \
    && apt-get install -y gcc

RUN pip install python-openstackclient

RUN apt-get autoremove -y --purge gcc \
    && apt-get clean autoclean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["openstack"]
