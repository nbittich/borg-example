FROM ubuntu:22.04

RUN apt update && apt install openssh-server sudo cron vim nano rsync  pipx fuse borgbackup gnupg uuid-runtime -y
RUN mkdir /var/run/sshd
COPY ./id_rsa.pub /root/.ssh/id_rsa.pub
COPY ./id_rsa /root/.ssh/id_rsa
COPY ./id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/id_rsa.pub
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN pipx ensurepath &&  pipx install borgmatic
RUN mv /root/.local/pipx/venvs/borgmatic/bin/borgmatic /usr/bin
CMD ["/usr/sbin/sshd", "-D"]
