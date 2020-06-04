# ------------------------------------ #
#                                      #
#   SyncTERM as a Web Service          #
#   Docker multi-stage build           #
#   by Jaromaz https://jm.iq.pl        #
#   https://github.com/jaromaz/stws    #
#                                      #
# ------------------------------------ #


# ---------- Builder ----------------- #

FROM debian:10.4-slim as builder-stws

LABEL stage=builder-stws

RUN apt-get update && apt-get install -y git patch

WORKDIR /tmp

RUN git clone https://github.com/novnc/noVNC.git && \
    ( \
        cd noVNC && \
        git checkout -b novnc 42e3b03 && \
        rm -r .git* \
    ) && \
    git clone https://github.com/novnc/websockify && \
    ( \
        cd websockify && \
        git checkout -b websockify 86a20b2 && \
        rm -r .git* \
    ) && \
    mv websockify noVNC/utils && \
    git clone https://github.com/robinparisi/tingle.git && \
    ( \
        cd tingle && \
        git checkout -b tingle 928dea3 && \
        rm -r .git* \
    ) && \
    mv tingle noVNC

COPY ./syncterm /tmp/syncterm

RUN patch noVNC/vnc.html < syncterm/stws.patch && \
    cp -r noVNC syncterm/stws/ && \
    mkdir syncterm/.vnc && \
    rm syncterm/stws.patch && \
    mkdir syncterm/stws/noVNC/files && \
    gzip -d syncterm/stws/bin/syncterm.gz



# -------- SyncTERM container -------- #

FROM debian:10.4-slim

LABEL maintainer="Jaromaz [https://jm.iq.pl]"

RUN adduser --disabled-password --gecos '' syncterm && \
    apt-get update && \
    apt-get install -y tightvncserver libncurses5 python3 python3-numpy procps && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER syncterm

ENV USER syncterm

WORKDIR /home/syncterm

COPY --chown=syncterm:syncterm --from=builder-stws /tmp/syncterm /home/syncterm

EXPOSE 6080

ENTRYPOINT ["./stws/bin/entrypoint.sh"]

