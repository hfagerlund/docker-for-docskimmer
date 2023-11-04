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
> *(using MkDocs v1.5.3 with docSkimmer theme v0.4.0)*

```console
$ sudo docker build . -t my-docskimmer -f Dockerfile
[+] Building 11.2s (12/12) FINISHED
 => [internal] load .dockerignore                                          0.2s
 => => transferring context: 2B                                            0.0s
 => [internal] load build definition from Dockerfile                       0.4s
 => => transferring dockerfile: 686B                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.8.2            0.8s
 => [1/7] FROM docker.io/library/python:3.8.2@sha256:8c98602bf4f4b2f9b6bd  0.0s
 => [internal] load build context                                          0.2s
 => => transferring context: 18.65kB                                       0.0s
 => CACHED [2/7] RUN apt-get install -y git &&     git clone https://gith  0.0s
 => CACHED [3/7] WORKDIR /mkdocs-docskimmer                                0.0s
 => CACHED [4/7] RUN pip install mkdocs==1.5.3 &&     rm -r docs           0.0s
 => [5/7] COPY docs_local-updates docs                                     0.8s
 => [6/7] RUN mkdocs build --clean                                         2.4s
 => [7/7] RUN mkdocs --version                                             3.1s
 => exporting to image                                                     1.9s
 => => exporting layers                                                    1.8s
 => => writing image sha256:f67b0c96211b1d95031449d4fc952fc387f68df4be54b  0.0s
 => => naming to docker.io/library/my-docskimmer                           0.1s

## NOTE: warnings (below) do not break the build

$ sudo docker run -p 8000:8080 my-docskimmer
WARNING -  Config value 'google_analytics': The configuration option google_analytics has been deprecated and will be removed in a future release of MkDocs. See the options available on your theme for an alternative.
WARNING -  Config value 'dev_addr': The use of the IP address '0.0.0.0' suggests a production environment or the use of a proxy to connect to the MkDocs server. However, the MkDocs' server is intended for local development purposes only. Please use a third party production-ready server instead.
INFO    -  Building documentation...
INFO    -  Cleaning site directory
INFO    -  Documentation built in 0.08 seconds
INFO    -  [21:42:17] Watching paths for changes: 'docs', 'mkdocs.yml'
INFO    -  [21:42:17] Serving on http://0.0.0.0:8080/mkdocs-docskimmer/
INFO    -  [21:42:17] Browser connected: http://0.0.0.0:8000/mkdocs-docskimmer/
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
* **line 10**: Use this for [latest version of docSkimmer theme](https://github.com/hfagerlund/mkdocs-docskimmer/releases) (**v0.4.0** - *at time of writing*);

* **...or** uncomment and modify **line 12**: to specify another version of docSkimmer theme - example: `v0.3.1` (also remove **line 10**)

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
