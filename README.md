[![GitHub Stars](https://img.shields.io/github/stars/edifus/docker-deluge.svg?color=337ab7&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/edifus/docker-deluge)
[![GitHub Release](https://img.shields.io/github/release/edifus/docker-deluge.svg?color=337ab7&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/edifus/docker-deluge/releases)
[![Docker Stars](https://img.shields.io/docker/stars/edifus/deluge.svg?color=337ab7&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/edifus/deluge)
[![Docker Pulls](https://img.shields.io/docker/pulls/edifus/deluge.svg?color=337ab7&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/edifus/deluge)
[![Docker Image Size](https://img.shields.io/docker/image-size/edifus/deluge.svg?color=337ab7&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=size&logo=docker)](https://hub.docker.com/r/edifus/deluge)

# [edifus/deluge](https://github.com/edifus/docker-deluge)

[Deluge](http://deluge-torrent.org/) is a lightweight, Free Software, cross-platform BitTorrent client.

* Full Encryption
* WebUI
* Plugin System
* Much more...

[![deluge](https://avatars2.githubusercontent.com/u/6733935?v=3&s=200)](http://deluge-torrent.org/)


## Supported Architectures

| Architecture | Tag |
| :----: | --- |
| x86-64 | latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose (recommended)

Compatible with docker-compose v2 schemas.

```yaml
---
version: "2.1"
services:
  deluge:
    image: edifus/deluge
    container_name: deluge
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - UMASK_SET=022 #optional
      - DELUGE_LOGLEVEL=error #optional
      - DOCKER_MODS=edifus/mods:deluge-filebot #optional
    volumes:
      - /path/to/deluge/config:/config
      - /path/to/your/downloads:/downloads
    restart: unless-stopped
```

### docker cli

```
docker run -d \
  --name=deluge \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e UMASK_SET=022 `#optional` \
  -e DELUGE_LOGLEVEL=error `#optional` \
  -e DOCKER_MODS=edifus/mods:deluge-filebot `#optional` \
  -v /path/to/deluge/config:/config \
  -v /path/to/your/downloads:/downloads \
  --restart unless-stopped \
  edifus/deluge
```


## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `--net=host` | Shares host networking with container, **required**. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use |
| `-e UMASK_SET=022` | for umask setting of deluge, default if left unset is 022 |
| `-e DELUGE_LOGLEVEL=error` | set the loglevel output when running Deluge, default is info for deluged and warning for delgued-web |
| `-e DOCKER_MODS=user/repo:tag` | enable optional mods |
| `-v /config` | deluge configs |
| `-v /downloads` | torrent download directory |


## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.


## Umask for running applications

This image provides the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod, it masks permissions based on it's value. Please read up [here](https://en.wikipedia.org/wiki/Umask) for more information.


## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, you avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


## Application Setup
* The admin interface is available at `http://SERVER-IP:8112` with a default user/password of admin/deluge.
* To change the password (recommended) log in to the web interface and go to Preferences->Interface->Password.
* Change the downloads location in the webui in Preferences->Downloads and use /downloads for completed downloads.


## Docker Mods
* [Filebot mod](https://github.com/edifus/docker-mods/tree/deluge-filebot)
  * Adds MediaInfo and Filebot to support [FileBotTool plug-in](https://github.com/Laharah/deluge-FileBotTool)


## Support Info
* Shell access whilst the container is running: `docker exec -it deluge /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f deluge`


## Updating Info

Below are the instructions for updating containers:

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull deluge`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d deluge`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run
* Update the image: `docker pull edifus/deluge`
* Stop the running container: `docker stop deluge`
* Delete the container: `docker rm deluge`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (only use if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower --run-once deluge
  ```
* You can also remove the old dangling images: `docker image prune`

### Image Update Notifications - Diun (Docker Image Update Notifier)
* Recommended to use [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended.


## Building locally
* If you want to make local modifications to these images for development purposes or just to customize the logic:
  ```
  git clone https://github.com/edifus/docker-deluge.git
  cd docker-deluge
  docker build  --no-cache --pull -t edifus/deluge:test .
  ```


## Versions

* **2021-01-01:** - Fork from linuxserver.io - Revert to Deluge 1.3.15 (plug-in support) - amd64 only

