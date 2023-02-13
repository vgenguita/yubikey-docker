#!/bin/bash
service pcscd start
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg --card-status
cd ~/.gnupg
wget https://raw.githubusercontent.com/drduh/config/master/gpg-agent.conf
cd /root
gpg-connect-agent updatestartuptty /bye
bash
