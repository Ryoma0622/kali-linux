FROM kalilinux/kali-rolling

RUN apt-get update -y -q \
  && apt-get install -y -q zsh tightvncserver net-tools curl openssh-server

RUN adduser --disabled-password --gecos "" kali && \
    echo "kali:kali" | chpasswd && \
    usermod -aG sudo kali
RUN chsh -s /usr/bin/zsh kali

RUN apt-get -y install kali-linux-core kali-defaults kali-tools-web

RUN apt-get -y install kali-desktop-xfce x11vnc xvfb xfce4 xfce4-goodies novnc dbus-x11

RUN apt-get -y install tor python3 python3-pip

COPY torrc /etc/tor/torrc

EXPOSE 5900
EXPOSE 8081

USER kali

ENTRYPOINT tor && zsh
