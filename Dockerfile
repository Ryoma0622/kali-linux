FROM kalilinux/kali-rolling

ARG DISPLAY_NUMBER=1
ENV DISPLAY=:$DISPLAY_NUMBER

RUN apt-get update -y -q \
  && apt-get install -y -q zsh tightvncserver net-tools curl openssh-server

RUN apt-get -y install kali-linux-core kali-defaults kali-tools-web

RUN apt-get -y install kali-desktop-xfce x11vnc xvfb xfce4 xfce4-goodies novnc dbus-x11

RUN adduser kali
RUN usermod -G sudo kali

ENV DISPLAY=:1

EXPOSE 5900
EXPOSE 8081

CMD Xvfb :1 -screen 0 1280x720x24 & \
    startxfce4 & x11vnc -display :1 -xkb -forever -shared -repeat -listen 0.0.0.0 -nopw -reopen & \
    /usr/share/novnc/utils/launch.sh --listen 8081 --vnc localhost:5900

ENTRYPOINT /bin/bash
