FROM kalilinux/kali-rolling

ARG DISPLAY_NUMBER=1
ENV DISPLAY=:$DISPLAY_NUMBER

RUN apt-get update -y -q \
  && apt-get install -y -q zsh tightvncserver net-tools curl openssh-server

RUN apt-get -y install kali-linux-core kali-defaults kali-tools-web

RUN apt-get -y install kali-desktop-xfce x11vnc xvfb xfce4 xfce4-goodies novnc dbus-x11

RUN apt-get -y install tor python3 python3-pip

COPY torrc /etc/tor/torrc

RUN adduser kali
RUN usermod -G sudo kali

EXPOSE 5900
EXPOSE 8081

USER kali

ENTRYPOINT zsh
