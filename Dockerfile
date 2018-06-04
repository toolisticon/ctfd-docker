FROM ctfd/ctfd

LABEL authors="Martin Reinhardt <martin.reinhardt@holisticon.de>"
LABEL vendor="Holisticon AG"

COPY docker-entrypoint.sh /opt/CTFd/

# uwsgi allows better webserver support
RUN apk add py-configobj libusb py-pip python-dev gcc linux-headers && \
  pip install --upgrade pip && \
  pip install -U setuptools && \
  pip install uwsgi
