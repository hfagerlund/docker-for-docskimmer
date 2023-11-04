# set Python version 
# as per https://www.mkdocs.org/user-guide/installation/
FROM python:3.8.2

# set MkDocs version
ENV MKDOCS_VERSION="1.5.3"

RUN apt-get install -y git && \
    # clones latest version
    git clone https://github.com/hfagerlund/mkdocs-docskimmer.git
    # clone an alternative version - example: 
    # git clone https://github.com/hfagerlund/mkdocs-docskimmer.git --branch v0.3.1
WORKDIR /mkdocs-docskimmer

RUN pip install mkdocs==${MKDOCS_VERSION} && \
    rm -r docs

COPY docs_local-updates docs
RUN mkdocs build --clean

RUN mkdocs --version

EXPOSE 80

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.00:8080"]
