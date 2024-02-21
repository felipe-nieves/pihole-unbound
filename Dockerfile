FROM pihole/pihole:latest

RUN apt update && apt install -y unbound wget
COPY lighttpd-external.conf /etc/lighttpd/external.conf 
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run
RUN chmod 777 /etc/services.d/unbound/run
RUN wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints

ENTRYPOINT ./s6-init
