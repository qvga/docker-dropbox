FROM frolvlad/alpine-glibc

RUN addgroup -g 1001 dropbox && adduser -D -u 1001 -G dropbox dropbox
WORKDIR /home/dropbox
RUN apk add --no-cache dumb-init python \
&& wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - \
&& wget https://www.dropbox.com/download?dl=packages/dropbox.py -O /usr/local/bin/dropbox.py \
&& chmod +x /usr/local/bin/dropbox.py \
&& mkdir -p /home/dropbox/.dropbox && mkdir -p /home/dropbox/Dropbox \
&& chown -Rv dropbox:dropbox /home/dropbox

USER dropbox

EXPOSE 17500

ENTRYPOINT ["dumb-init", "--"]
CMD .dropbox-dist/dropboxd
