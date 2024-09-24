docker build -t kali-linux-x-tor-vnc .
docker volume create kali-linux-x-tor-vnc
docker run -it --rm \
  -p "5905:5900" \
  -p "8081:8081" \
  -v "kali-linux-x-tor-vnc:/home/kali" \
  -v "$HOME/dev/:/mnt/dev" \
  --name kali-linux-x-tor-vnc \
  kali-linux-x-tor-vnc zsh -c 'su - kali'
