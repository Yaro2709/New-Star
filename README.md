# New-Star

New-Star is a web browser game engine. The goal of this work is to completely restart 2Moons: a new design, a new gameplay and much more. The open source browsergame framework is based on [2Moons](https://github.com/jkroepke/2Moons). 

## Website New-Star

Do you want to know more about us? Then go to our [website](https://yaro2709.github.io/New-Star-website).

## Gallery New-Star

There is also a [gallery](https://yaro2709.github.io/New-Star-website/gallery) of the project so that anyone can visually familiarize themselves with the project.

## Community New-Star

Want to keep abreast of the latest developments? Then come visit us on [Discord](https://discord.gg/pu7faEb), [Telegram](https://t.me/newstarnet), [Facebook](https://www.facebook.com/groups/newstarnet), [Instagram](https://www.instagram.com/newstarnet)!

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
- [sound] - media files
- [mods] - modifications that are devoid of support
- [scripts] - client-side web browser .js scripts
- [styles] 
  - webpages .css templates
  - webpages .tpl templates
  - fonts
  - images
 
## Local installation

- Clone the repo: `git clone https://github.com/New-Star/New-Star`
- Install components: `apt install apache2 php7.3 php7.3-gd php7.3-fpm php7.3-mysql php7.3-curl php-ds libapache2-mod mysql-server`
- Setup mysql: `create user USER identified by PASSWORD; create database DB; grant all privileges on DB.* to USER;`
- Set write privileges to dirs: `cache/`, `includes/`
- Run wizard: `127.0.0.1/install/install.php`