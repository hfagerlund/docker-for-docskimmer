# set Python version 
# as per https://www.mkdocs.org/user-guide/installation/
FROM python:3.8.2

# set MkDocs version
ENV MKDOCS_VERSION="1.5.3"

RUN apt-get install -y git && \
    # RE: https://github.com/hfagerlund/mkdocs-docskimmer/discussions/18

    ## clone latest version
    ## git clone https://github.com/hfagerlund/mkdocs-docskimmer.git

    ## clone an alternative version - example:
    ## git clone https://github.com/hfagerlund/mkdocs-docskimmer.git --branch v0.3.1

    ## pip install latest version
    ## pip install git+https://github.com/hfagerlund/mkdocs-docskimmer.git

    ## pip install branch
    pip install git+https://github.com/hfagerlund/mkdocs-docskimmer.git@issue-17_fix-config-value

RUN pip install mkdocs==${MKDOCS_VERSION}

COPY docs_local-updates docs
RUN mkdocs build --clean

RUN mkdocs --version

EXPOSE 80

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.00:8080"]
