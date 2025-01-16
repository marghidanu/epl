FROM perl:5.34-slim

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential libyaml-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

COPY cpanfile .
RUN cpanm -nq --installdeps .

COPY bin/ bin/
COPY examples examples/

ENV PATH="/opt/app/bin:${PATH}"

ENTRYPOINT [ "e.pl" ]
