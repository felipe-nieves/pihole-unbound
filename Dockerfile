FROM pihole/pihole:latest

RUN apk update && apk add unbound wget
COPY lighttpd-external.conf /etc/lighttpd/external.conf 
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
RUN echo 'include: "/etc/unbound/unbound.conf.d/pi-hole.conf"' > /etc/unbound/unbound.conf
RUN mkdir -p /var/log/unbound && \
    touch /var/log/unbound/unbound.log && \
    chown -R unbound:unbound /var/log/unbound && \
    chmod 644 /var/log/unbound/unbound.log
COPY init /start.sh
RUN chmod +x /start.sh
RUN wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

ENTRYPOINT ["/start.sh"]
