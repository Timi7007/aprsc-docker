# debian 11 is the most recent debian version that aprsc supports
FROM debian:bullseye-slim

# install requirements and aprsc
ADD ./aprsc_2.1.14.g5e22b37+bullseye1_armhf.deb /opt/
RUN apt update && apt install -y libcap2 libevent-2.1-7 libwww-perl libjson-xs-perl libcap2-bin libsctp1
RUN export DEBIAN_FRONTEND="noninteractive" && dpkg -i /opt/aprsc_2.1.14.g5e22b37+bullseye1_armhf.deb

# change the aprsc user's uid to 1000 so that volume permissions translate
# between the first non-root user on the host
RUN usermod -u 1000 aprsc

# start the service and follow the logs so that container doesn't exit
CMD service aprsc start && tail -F /opt/aprsc/logs/aprsc.log
