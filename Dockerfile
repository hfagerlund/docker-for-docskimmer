# set Python version 
# as per https://www.mkdocs.org/user-guide/installation/
FROM python:3.8.2

# set MkDocs version
ENV MKDOCS_VERSION="1.5.3"

WORKDIR /build

RUN pip install mkdocs==${MKDOCS_VERSION} && \
    mkdocs new my-project

RUN apt-get install -y git && \
    # install latest version (modify to install another tag or branch - eg. ...@v0.3.1)
    pip install git+https://github.com/hfagerlund/mkdocs-docskimmer.git@master

RUN cd my-project
COPY docs_local-updates ./my-project/docs

RUN echo 'site_name: docker-for-docskimmer\n\
theme:\n\
  name: docskimmer\n\
  include_search_page: true\n\
  search_index_only: false\n\
  static_templates:\n\
  - 404.html\n\
plugins: ['search']\n\
extra:\n\
    version: 0.4.0'\ >> ./my-project/mkdocs.yml

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.00:8080", "--config-file=./my-project/mkdocs.yml"]
