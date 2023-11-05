# set Python version 
# as per https://www.mkdocs.org/user-guide/installation/
FROM python:3.8.2

# set MkDocs version
ENV MKDOCS_VERSION="1.5.3"

RUN apt-get install -y git && \
    pip install git+https://github.com/hfagerlund/mkdocs-docskimmer.git@issue-17_fix-config-value

RUN pip install mkdocs==${MKDOCS_VERSION} && \
    mkdocs new my-project && \
    cd my-project

COPY docs_local-updates docs
# RUN mkdocs build --clean

RUN mkdocs --version

EXPOSE 80

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.00:8080"]
