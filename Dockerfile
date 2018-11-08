FROM frolvlad/alpine-glibc

RUN addgroup -g 1000 dropbox && adduser -D -u 1000 -G dropbox dropbox
WORKDIR /home/dropbox
RUN apk add --no-cache dumb-init python \
    && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - \
    && wget https://www.dropbox.com/download?dl=packages/dropbox.py -O /usr/local/bin/dropbox-cli \
    && mkdir -p /home/dropbox/.dropbox /home/dropbox/Dropbox \
    && chmod +x /usr/local/bin/dropbox-cli \
    && chown dropbox:dropbox /usr/local/bin/dropbox-cli \
    && chown dropbox:dropbox -R /home/dropbox/ 

USER dropbox

EXPOSE 17500

ENTRYPOINT ["dumb-init", "--"]
CMD .dropbox-dist/dropboxd
