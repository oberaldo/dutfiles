## Dzen2 config files (ARCH/XFCE)

Disclaimer: | Use my files at your own risk!
--- | ---



**strangeWORLD**
![screenshot](https://github.com/Ksiencha/Dzen2/blob/master/Screenshot.png)

* [PREREQUISITES](https://github.com/Ksiencha/Dzen2/blob/master/README.md#prerequisites)
* [INSTALLATION](https://github.com/Ksiencha/Dzen2/blob/master/README.md#installation)

### PREREQUISITES
---
#### 1. CPU Temperature

    $ sudo pacman -S i2c-tools
    $ sudo sensors-detect       # Answer 'y' on every question
    $ sensors

#### 2. Battery state

    $ sudo pacman -S acpi
    $ acpi -V

#### 3. Wget tool

    $ sudo pacman -S wget

#### 4. Checking current keayboard layout in use

    $ yaourt -S xkblayout-state

#### 5. Install calculator

    $ sudo pacman -S bc

#### 6. Install JSON parsers 

6.1. Install jq parser - http://stedolan.github.io/jq/ (read the Install file in folder **jq-JSON-parser**)

6.2. Insall jshon parser

    $ sudo pacman -S jshon

#### 7. Install dropbox-cli

    $  yaourt -S dropbox-cli
    
#### 8. Weather Forecast

In order to obtain an API key you have to create your own account on https://developer.forecast.io/ (it's free, and the first 1000 calls per day are free, which is plenty as for me)
Read through their [documentation](https://developer.forecast.io/docs/v2) in order to get the url with json queries that you want. For exapmle, my url contains queries which enable Celsius degrees `units=si` and exclude "hourly" and "flags" data blocks `exclude=hourly,flags`:

        https://api.forecast.io/forecast/API_KEY/LATITUDE,LONGITUDE?units=si&exclude=hourly,flags


#### 9. Fonts

You can find them in **Fonts** directory:

* FontAwesome (http://fortawesome.github.io/Font-Awesome/)
* Ionicons (http://ionicons.com/)
* Typicons (http://www.typicons.com/)
* Weather Icons (https://github.com/erikflowers/weather-icons)

**Note!**

If you want to download the latest version of **Ionicons** font from the official website there will be no Pacman and Arch icons. The **Fonts** directory contains the patched version of this font with previously mentioned icons.


### INSTALLATION
---

#### 1. Install dzen2

    $ sudo pacman -S dzen2

#### 2. Place your Dzen2 folder into your `/home/username/` directory
#### 3. Make all `.sh` files executable

    $ cd ~/Dzen2/dzen-configs/strangeWORLD
    $ sudo cp dzen_start /bin/
    $ sudo chmod +x *.sh
    $ sudo chmod +x /bin/dzen_start

#### 4. Edit .conkyrcdzen1 file

**Gmail Account**

Find  the line `Upload and parse gmail info`

        ${execi 60 curl -u username:password --silent "https://mail.google.com/mail/feed/atom" -o ~/.cache/gmail.xml && xmllint --format ~/.cache/gmail.xml > ~/.cache/gmailParsed.xml}

Change `username:password` respectively. 

**Weather Forecast**

1. Find the line `Upload and parse weather info`

        ${execi 900 curl -X GET --silent "https://api.forecast.io/forecast/API_KEY/LATITUDE,LONGITUDE" > ~/.cache/Forecast.json}

You need to replcase `API_KEY` and `LATITUDE,LONGITUDE` fields.

#### 4. Starting dzen2

**Manually start**

    $ dzen_start

**Manually stop**

    $ killall dzen2

**Automatically on boot (FOR XFCE USERS)**

Settings Manager **>>** Session and Startup **>>** Application Autostart **>>** Add

Command: `/bin/dzen_start`
