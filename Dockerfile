FROM paperist/texlive-ja:latest

COPY entrypoint.sh /usr/bin/

RUN apt-get update -y && \
apt-get install -y wget fontconfig && \
wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.8.1_all.deb && \
apt install -y ./ttf-mscorefonts-installer_3.8.1_all.deb

RUN fc-cache -f -v

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
