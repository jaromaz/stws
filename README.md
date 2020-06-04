# SyncTERM Web Service

## Description

**stws** alows SyncTERM (BBS terminal program) to by accessible through a standard Web browser in a full screen mode. It also makes *Telnet BBS Guide* and *files downloaded from BBSes* available through the web interface in a full screen mode (recommended browser: Google Chrome).


## Usage

You can simply run the container by entering:

    docker run -d -p 6080:6080 jaromaz/stws
    
then simply point your browser at: 

    http://<your-docker-server-ip>:6080

Default ***password*** *:* syncterm

To create your own password, run a container with the environment variable PASSWD:

    docker run -e PASSWD=mypass -d -p 6080:6080 jaromaz/stws
    
You can also use a password file:

    docker run --env-file ./passwd -d -p 6080:6080 jaromaz/stws

## Demo

This video presents file downloading via telnet and SyncTERM Web Service:

<img src="https://jm.iq.pl/bbs/video.png" width="480">

## Built with

* [SyncTERM](https://syncterm.bbsdev.net)
* [X-Org](https://www.x.org)
* [TightVNC Server](https://www.tightvnc.com/licensing-tvnserver.php)
* [noVNC](https://github.com/novnc/noVNC)
* [websockify](https://github.com/novnc/websockify)
* [Tingle.js](https://github.com/robinparisi/tingle)

## Build from source

If you want to make local modifications to this image for development purposes, just copy and run the following lines:

    git clone https://github.com/jaromaz/stws.git && \
    cd stws && \
    docker build --tag stws:latest --no-cache . && \
    echo y | docker image prune --filter "label=stage=builder-stws" && \
    docker run -d -p 6080:6080 stws

## Author

Jarosław Mazurkiewicz / **Jaromaz**

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE Version 3 - see the LICENSE file for details. I recommend to
check the licenses assigned to the individual components of this project.

