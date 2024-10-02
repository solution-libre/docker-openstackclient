# Copyright (C) 2024 Solution Libre
# 
# This file is part of OpenStack Client Docker Image.
# 
# OpenStack Client Docker Image is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# OpenStack Client Docker Image is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with OpenStack Client Docker Image.  If not, see <https://www.gnu.org/licenses/>.

FROM python:alpine

ARG VERSION=7.1.2

LABEL org.opencontainers.image.authors="Solution Libre <contact@solution-libre.fr>" \
      org.opencontainers.image.base.name="python:alpine" \
      org.opencontainers.image.description="Command-line client for OpenStack" \
      org.opencontainers.image.documentation="https://usine.solution-libre.fr/docker/openstackclient/-/blob/main/README.md" \
      org.opencontainers.image.licenses="GPL-3.0-or-later" \
      org.opencontainers.image.ref.name="openstackclient" \
      org.opencontainers.image.source="https://usine.solution-libre.fr/docker/openstackclient/-/tree/main/" \
      org.opencontainers.image.url="https://usine.solution-libre.fr/docker/openstackclient/" \
      org.opencontainers.image.title="OpenStackClient" \
      org.opencontainers.image.vendor="Solution Libre" \
      org.opencontainers.image.version="${VERSION}"

# hadolint ignore=DL3018
RUN apk update \
    && apk --no-cache add gcc musl-dev linux-headers \
    && pip install --no-cache-dir python-openstackclient==${VERSION} \ 
    && apk del gcc musl-dev linux-headers \
    && rm -rf /var/cache/apk/*

ENV USER_NAME=openstack
ENV GROUP_NAME=openstack

RUN addgroup $GROUP_NAME \
    && adduser --shell /sbin/nologin --disabled-password \
        --no-create-home --ingroup $GROUP_NAME $USER_NAME

USER $USER_NAME

ENTRYPOINT ["openstack"]
