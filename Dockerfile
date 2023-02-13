FROM ubuntu
RUN apt update -y && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y console-setup
RUN apt install -y git curl gpg wget
RUN apt install -y gnupg2 gnupg-agent dirmngr cryptsetup pcscd secure-delete hopenpgp-tools yubikey-personalization scdaemon yubico-piv-tool
#YKMAN
RUN apt -y install python3-pip python3-pyscard
RUN pip3 install PyOpenSSL
RUN pip3 install yubikey-manager
# Debug tools
RUN apt install vim usbutils -y
RUN rm -rf /var/lib/apt/lists/*
COPY init.sh .
RUN chmod 700 init.sh
ENV GPG_TTY="/dev/pts/0"
ENTRYPOINT ./init.sh
