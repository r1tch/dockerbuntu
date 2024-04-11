#!/bin/bash

create_user_if_needed() {
  # Check if the user already exists
  getent passwd $USERNAME > /dev/null

  if [ $? -ne 0 ]; then
      # User doesn't exist, so let's add the user
      useradd -m $USERNAME -s /bin/bash
      echo "$USERNAME:$PASSWORD" | chpasswd
      adduser $USERNAME sudo
      chown $USERNAME:$USERNAME /home/$USERNAME

      # get root without password:
      echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

      # copy templates from /root
      if [ ! -f /home/$USERNAME/.bashrc ] 
      then
        cp -i /root/.bashrc /home/$USERNAME
        chown $USERNAME:$USERNAME /home/$USERNAME/.bashrc
      fi

      if [ ! -f /home/$USERNAME/.profile ] 
      then
        cp -i /root/.profile /home/$USERNAME
        chown $USERNAME:$USERNAME /home/$USERNAME/.profile
      fi
  fi
}

run_user_commands() {
  if [ -f /home/$USERNAME/.dockerbuntu_startup ]
  then
    . /home/$USERNAME/.dockerbuntu_startup
  fi
}

create_user_if_needed
run_user_commands

# start cron daemon, easy-peasy:
cron

# Start SSH service
/usr/sbin/sshd -D

