# set Python version 
# as per https://www.mkdocs.org/user-guide/installation/
FROM python:3.8.2

WORKDIR /build

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY docs_local-updates ./my-project/docs

COPY mkdocs.yml ./my-project/mkdocs.yml

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.00:8080", "--config-file=./my-project/mkdocs.yml"]
