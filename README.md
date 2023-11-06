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
[+] Building 2.6s (12/12) FINISHED
 => [internal] load .dockerignore                                                                    0.3s
 => => transferring context: 2B                                                                      0.0s
 => [internal] load build definition from Dockerfile                                                 0.5s
 => => transferring dockerfile: 902B                                                                 0.0s
 => [internal] load metadata for docker.io/library/python:3.8.2                                      0.6s
 => [1/7] FROM docker.io/library/python:3.8.2@sha256:8c98602bf4f4b2f9b6bd8def396d5149821c59f8a69e74  0.0s
 => [internal] load build context                                                                    0.2s
 => => transferring context: 266B                                                                    0.0s
 => CACHED [2/7] WORKDIR /build                                                                      0.0s
 => CACHED [3/7] RUN pip install mkdocs==1.5.3 &&     mkdocs new my-project                          0.0s
 => CACHED [4/7] RUN apt-get install -y git &&     pip install git+https://github.com/hfagerlund/mk  0.0s
 => CACHED [5/7] RUN cd my-project                                                                   0.0s
 => CACHED [6/7] COPY docs_local-updates ./my-project/docs                                           0.0s
 => CACHED [7/7] RUN echo 'site_name: docker-for-docskimmer\ntheme:\n  name: docskimmer\n  include_  0.0s
 => exporting to image                                                                               0.2s
 => => exporting layers                                                                              0.0s
 => => writing image sha256:d492c778359d31e425eced41632007f6ef537b2af36446ce9df770bf2c0097e6         0.1s
 => => naming to docker.io/library/my-docskimmer                                                     0.1s
## NOTE: warnings (below) do not break the build

$ sudo docker run -p 8000:8080 my-docskimmer
WARNING -  Config value 'dev_addr': The use of the IP address '0.0.0.0' suggests a production environment or the use of a proxy to connect to the MkDocs server. However, the MkDocs' server is intended for local development purposes only. Please use a third party production-ready server instead.
INFO    -  Building documentation...
INFO    -  Cleaning site directory
INFO    -  Documentation built in 0.08 seconds
INFO    -  [22:55:00] Watching paths for changes: 'my-project/docs', 'my-project/mkdocs.yml'
INFO    -  [22:55:00] Serving on http://0.0.0.0:8080/
INFO    -  [22:55:01] Browser connected: http://0.0.0.0:8000/search.html?q=sample
INFO    -  [22:55:01] Browser connected: http://0.0.0.0:8000/
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
Specify the version numbers of any/all of the following in the [Dockerfile](https://github.com/hfagerlund/docker-for-docskimmer/blob/main/Dockerfile):
#### Python
* **line 3**: Specify Python version (for compatibility with MkDocs - refer to [user guide](https://www.mkdocs.org/user-guide/installation/));
#### MkDocs
* **line 6**: Specify [MkDocs version](https://github.com/mkdocs/mkdocs/releases/) (latest: **v1.5.3** - *at time of writing*);
#### docSkimmer theme
* **line 15**: Specify the tag, release/version, or branch of [docSkimmer theme](https://github.com/hfagerlund/mkdocs-docskimmer/releases) (note: `master` branch contains the latest, unreleased changes since **v0.4.0**)

  **examples** <br>
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
