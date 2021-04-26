FROM python:3.8.6-buster

# Install missing libs libxslt-dbg
RUN apt-get update && \
    apt-get install -y nano telnet net-tools nginx supervisor iputils-ping procps nano libgdal-dev gdal-bin gcc curl libcairo2 libpango-1.0.0 libgdk-pixbuf2.0-0 libxml2 git libffi-dev python3-cffi libpq-dev && \
    apt-get -y install xvfb libfontconfig wget libssl-dev libfontconfig1 libxrender1 locales && \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
    tar vxf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
    cp wkhtmltox/bin/wk* /usr/local/bin/

RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && \
    export C_INCLUDE_PATH=/usr/include/gdal && \
    export COLUMNS=80

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Cleanup
RUN apt-get clean autoclean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /var/cache/apt/archives/*.deb && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.cache/* && \
    rm -rf /tmp/* && \
    rm -rf /usr/share/man/* && \
    rm -rf /usr/share/doc/* && \
    find /var/lib/apt -type f | xargs rm -f && \
    find /var/cache -type f -exec rm -rf {} \; && \
    find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Creating Application Source Code Directory
RUN mkdir -p /usr/app

# Setting Home Directory for containers
WORKDIR /usr/app

# Copying src code to Container
COPY . .

RUN pip install --no-cache-dir --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org pipenv

COPY Pipfile* /tmp/

RUN cd /tmp && pipenv lock --requirements > requirements.txt && \
    pip install --no-cache-dir --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org -r /tmp/requirements.txt && \
    pip install --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org gunicorn

COPY ${PWD}/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ${PWD}/supervisor/supervisor.conf /etc/supervisor/conf.d

# Exposing Ports
EXPOSE 80

# Environemnt variables
ENV DJANGO_ENV settings
ENV DJANGO_SETTINGS_MODULE config.${DJANGO_ENV}
ENV GUNICORN_BIND  0.0.0.0:8000
ENV GUNICORN_WORKERS 6
ENV GUNICORN_THREADS 6
ENV GUNICORN_WORKERS_CONNECTIONS 1001
ENV GUNICORN_TIMEOUT 300
