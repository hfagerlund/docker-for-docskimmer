# docker-for-docskimmer

This project uses a Dockerfile to automate git cloning the repo for easily testing the compatibility of **various [docSkimmer theme](https://github.com/hfagerlund/mkdocs-docskimmer) and [MkDocs](https://github.com/mkdocs/mkdocs) versions** (either current, or [otherwise specified](https://github.com/hfagerlund/docker-for-docskimmer#specify-versions)) *without having to install either locally*.

## Quickstart
```console
$ sudo systemctl start docker
$ sudo docker build . -t my-docskimmer -f Dockerfile
$ sudo docker run -p 8000:8080 my-docskimmer
```
* Browse to http://0.0.0.0:8000/mkdocs-docskimmer/ :tada:

## Example output
An excerpt of **successful build output** is shown below:
> *(using MkDocs v1.5.3 with docSkimmer theme 'master' branch)*

```console
$ sudo docker build . -t my-docskimmer -f Dockerfile
[+] Building 6.9s (11/11) FINISHED
 => [internal] load .dockerignore                                                                    0.4s
 => => transferring context: 2B                                                                      0.0s
 => [internal] load build definition from Dockerfile                                                 0.3s
 => => transferring dockerfile: 467B                                                                 0.0s
 => [internal] load metadata for docker.io/library/python:3.8.2                                      0.9s
 => [internal] load build context                                                                    0.2s
 => => transferring context: 618B                                                                    0.0s
 => [1/6] FROM docker.io/library/python:3.8.2@sha256:8c98602bf4f4b2f9b6bd8def396d5149821c59f8a69e74  0.0s
 => CACHED [2/6] WORKDIR /build                                                                      0.0s
 => CACHED [3/6] COPY requirements.txt .                                                             0.0s
 => CACHED [4/6] RUN pip install --no-cache-dir -r requirements.txt                                  0.0s
 => [5/6] COPY docs_local-updates ./my-project/docs                                                  1.0s
 => [6/6] COPY mkdocs.yml ./my-project/mkdocs.yml                                                    0.8s
 => exporting to image                                                                               2.4s
 => => exporting layers                                                                              2.2s
 => => writing image sha256:0274aee1e791ec0f0af2df18b3df607c41b0640a9fe2e7af0cbed8d8e24a94ac         0.1s
 => => naming to docker.io/library/my-docskimmer                                                     0.1s

## NOTE: warnings (below) do not break the build

$ sudo docker run -p 8000:8080 my-docskimmer
WARNING -  Config value 'dev_addr': The use of the IP address '0.0.0.0' suggests a production environment or the use of a proxy to connect to the MkDocs server. However, the MkDocs' server is intended for local development purposes only. Please use a third party production-ready server instead.
INFO    -  Building documentation...
INFO    -  Cleaning site directory
INFO    -  Documentation built in 0.29 seconds
INFO    -  [00:38:37] Watching paths for changes: 'my-project/docs', 'my-project/mkdocs.yml'
INFO    -  [00:38:37] Serving on http://0.0.0.0:8080/
INFO    -  [00:38:39] Browser connected: http://0.0.0.0:8000/
## ...
```

### Summary of steps
* start Docker: `$ sudo systemctl start docker`;
* build and tag the Docker image 'my-docskimmer': `$ sudo docker build . -t my-docskimmer -f Dockerfile`;
  * **NOTE**: run this in the same directory as the [Dockerfile](https://github.com/hfagerlund/docker-for-docskimmer/blob/main/Dockerfile))
* run Docker image 'my-docskimmer': `$ sudo docker run -p 8000:8080 my-docskimmer`;
  * this maps port 8080 in the container to port 8000 on the Docker host
* browse to http://0.0.0.0:8000/mkdocs-docskimmer/
  * see `view-source:http://0.0.0.0:8000/mkdocs-docskimmer/` for version numbers of both the docSkimmer theme and MkDocs

### Specify Versions
#### Python
* **line 3** of the [Dockerfile](https://github.com/hfagerlund/docker-for-docskimmer/blob/main/Dockerfile#L3): Specify the Python version (for compatibility with MkDocs - refer to [user guide](https://www.mkdocs.org/user-guide/installation/);

#### MkDocs
* **line 1** of [requirements.txt](https://github.com/hfagerlund/docker-for-docskimmer/blob/main/requirements.txt#L1): Specify the [MkDocs version](https://github.com/mkdocs/mkdocs/releases/) - (latest: **v1.5.3** - *at time of writing*);

#### docSkimmer theme
* **line 2** of [requirements.txt](https://github.com/hfagerlund/docker-for-docskimmer/blob/main/requirements.txt#L2): Specify the tag, release/version, or branch of [docSkimmer theme](https://github.com/hfagerlund/mkdocs-docskimmer/releases) - (note: `master` branch contains the latest, unreleased changes since **v0.4.0**)

  **examples**: <br>
  * install latest changes (ie. 'master' branch'):
  ```
  pip install git+https://github.com/hfagerlund/mkdocs-docskimmer.git@master
  ```
  * install version 0.3.1:
  ```
  pip install git+https://github.com/hfagerlund/mkdocs-docskimmer.git@v0.3.1
  ```
  * install experimental branch 'issue-17_fix-config-value':
  ```
  pip install git+https://github.com/hfagerlund/mkdocs-docskimmer.git@issue-17_fix-config-value
  ```


### Nice to know
<details>
  <summary>Docker commands<strong> [+]</strong></summary>

<br />

* List Docker images (eg. 'my-docskimmer'):
```console
$ sudo docker images
```

* List Docker containers:
```console
$ sudo docker container ls -a
```

* Remove Docker image 'my-docskimmer' once finished:
```console
$ sudo docker rmi -f my-docskimmer
```

* Debug Docker build (display output of commands not loaded from cache):
```console
$ sudo docker build --progress=plain --no-cache . -t my-docskimmer -f Dockerfile
```

* Stop Docker:
```console
$ sudo systemctl stop docker
```

* Check whether Docker is running:
```console
$ sudo systemctl status docker
```
</details>

## License
Copyright (c) 2023 Heini Fagerlund. Licensed under the [BSD-3-Clause license](https://github.com/hfagerlund/docker-for-docskimmer/blob/main/LICENSE).
