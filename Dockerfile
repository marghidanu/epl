FROM perl:5.34-slim

WORKDIR /opt/app

COPY cpanfile .
RUN cpanm -nq --installdeps .

COPY bin/ bin/
COPY examples examples/

ENV PATH="/opt/app/bin:${PATH}"

ENTRYPOINT [ "e.pl" ]
