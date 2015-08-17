FROM joshloyal/mldocker:0.1
MAINTAINER Joshua Loyal <jloyal25@gmail.com>

# setup ipython-notebook server
ENV PORT_IPYTHON=8080

ENV WORKDIR=/home/datum
COPY start.sh /home/datum/

RUN ipython profile create default &&\
    /bin/echo -e "c.NotebookApp.ip = '*'\nc.NotebookApp.open_browser = False\nc.NotebookApp.port = $PORT_IPYTHON\n" | \
    tee -a /home/datum/.ipython/profile_default/ipython_notebook_config.py

# expose ports
EXPOSE $PORT_IPYTHON
EXPOSE 5000

CMD ["bash", "/home/datum/start.sh"]
