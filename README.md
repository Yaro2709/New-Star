# New-Star

New-Star is a web browser game engine. The goal of this work is to completely restart 2Moons: a new design, a new gameplay and much more. The open source browsergame framework is based on [2Moons](https://gitter.im/2MoonsGame/Lobby/). 

## Repository structure

- [cache] - temporary cached server .tpl webpages
- [chat] - AJAX ingame client-side chat
- [includes]
  - game engine
  - configuration
  - administration
  - database scheme
  - external libraries
  - webpages functionality
- [install]
  - first installation
  - database creation
- [language] - translations: EN, RU
- [licenses] - open source license schemes
- [media] - media files
- [mods] - modifications that are devoid of support
- [scripts] - client-side web browser .js scripts
- [styles] 
  - webpages .css templates
  - webpages .tpl templates
  - fonts
  - images
 
## Local installation

- Clone the repo: `git clone https://github.com/steemnova/steemnova`
- Install components: `apt install apache2 php7.3 php7.3-gd php7.3-fpm php7.3-mysql php7.3-curl php-ds libapache2-mod mysql-server`
- Setup mysql: `create user USER identified by PASSWORD; create database DB; grant all privileges on DB.* to USER;`
- Set write privileges to dirs: `cache/`, `includes/`
- Run wizard: `127.0.0.1/install/install.php`

## What have we done:

1. Completely rewritten the design of the game and about 30% of the functionality.
2. Created new functionality: about 15 new modifications.
3. We completely rewrote the authorization design and partially changed the functionality.
4. We completely rewrote the design of the install and partially changed the functionality.