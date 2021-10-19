FROM debian:latest
COPY  provisioners/* /opt/provisioners/
RUN ["/bin/bash", "-c", "sudo /opt/provisioners/install-required.sh"]
RUN ["/bin/bash", "-c", "sudo /opt/provisioners/install-ada.sh"]
RUN ["/bin/bash", "-c", "sudo /opt/provisioners/install-lustre-tools.sh"]
RUN ["/bin/bash", "-c", "sudo /opt/provisioners/install-forsyde-tools.sh"]
RUN ["/bin/bash", "-c", "sudo /opt/provisioners/patch-user.sh"]
RUN ["/bin/bash", "-c", "sudo /opt/provisioners/patch-drivers.sh"]
ENTRYPOINT /bin/bash
