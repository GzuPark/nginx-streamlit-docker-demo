FROM python:3.9.10-slim
LABEL maintainer "https://gzupark.dev"

RUN apt-get -qq update && \
    apt-get -y install wget gnupg && \
    wget https://nginx.org/keys/nginx_signing.key && \
    cat nginx_signing.key | apt-key add - && \
    apt-get -qq update && \
    apt-get -y install nginx && \
    rm nginx_signing.key && \
    rm -rf /var/lib/apt/lists/*    

COPY requirements.txt requirements.txt
RUN python -m pip install --no-cache-dir -r requirements.txt

RUN useradd -m -u 2022 -d /home/streamlitapp streamlitapp
RUN chown -R streamlitapp /var/log/nginx /var/lib/nginx

# Config and exec files
COPY --chown=streamlitapp ./config/nginx.conf /home/streamlitapp/.nginx/nginx.conf
COPY --chown=streamlitapp ./config/config.toml /home/streamlitapp/.streamlit/config.toml
COPY --chown=streamlitapp ./bin /home/streamlitapp/bin/
COPY --chown=streamlitapp ./app /home/streamlitapp/app/

# Paths
ENV PYTHONPATH "${PYTHONPATH}:/home/streamlitapp/app"
ENV PATH "${PATH}:/home/streamlitapp/src/bin:/home/streamlitapp/src/server/bin"

WORKDIR /home/streamlitapp/app
USER streamlitapp

RUN ["chmod", "+x", "/home/streamlitapp/bin/start-nginx.sh"]
ENTRYPOINT ["/home/streamlitapp/bin/start-nginx.sh"]

CMD ["streamlit", "run", "main.py"]
