if [ -z "$(docker images -q kali-linux-x-tor-vnc 2> /dev/null)" ]; then
  docker build -t kali-linux-x-tor-vnc .
fi

if [ -z "$(docker volume ls | grep kali-linux-x-tor-vnc 2> /dev/null)" ]; then
  docker volume create kali-linux-x-tor-vnc
fi

if [[ ! -e $HOME/dev ]]; then
  mkdir -p $HOME/dev
fi

if [ ! -z "$(docker ps | grep kali-linux-x-tor-vnc 2> /dev/null)" ]; then
  docker kill kali-linux-x-tor-vnc
fi

docker run -it -d --rm \
  -p "5905:5900" \
  -p "8081:8081" \
  -v "kali-linux-x-tor-vnc:/home/kali" \
  -v "$HOME/dev/:/mnt/dev" \
  --name kali-linux-x-tor-vnc kali-linux-x-tor-vnc

sleep 5

docker exec -d kali-linux-x-tor-vnc bash -c "Xvfb :1 -screen 0 1280x720x24 & \
    startxfce4 & \
    x11vnc -display :1 -xkb -forever -shared -repeat -listen 0.0.0.0 -nopw -reopen & \
    /usr/share/novnc/utils/novnc_proxy --listen 8081 --vnc localhost:5900"
