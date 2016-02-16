# Netatalk for Debian Jessie

This Docker container will build netatalk for Debian Jessie. The information for this container was gathered from the netatalk [wiki](http://netatalk.sourceforge.net/wiki/index.php/Install_Netatalk_3.1.8_on_Debian_8_Jessie).

### Usage

Currently this container builds version `3.1.8` of netatalk.

```sh
mkdir ~/artifact
docker run -it --rm -v ~/artifact:/artifact ironicbadger/build-netatalk3-debian
docker rmi ironicbadger/build-netatalk3-debian
dpkg -i ~/artifact/*.deb
```

You'll also need to link a library, else netatalk won't start [source](http://netatalk.sourceforge.net/wiki/index.php/Install_Netatalk_v3_on_Debian#Installing_Netatalk_3_using_Checkinstall).

```sh
echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig
```

### Configuring AFP

Edit `/usr/local/etc/afp.conf`

```sh
[Global]

[Homes]
    basedir regex = /home

[Test Volume]
    path = /export/test1

[My Time Machine Volume]
    path = /export/timemachine
    time machine = yes
    vol size limit = 512000
```

### Starting the service

```sh
systemctl enable avahi-daemon
systemctl enable netatalk
systemctl start avahi-daemon
systemctl start netatalk
```

### Spotlight

If you use Spotlight feature, read Spotlight section in Netatalk Manual.
Set `spotlight = yes` and `dbus daemon = /usr/bin/dbus-daemon`.
Set `spotlight = no` for Time Machine's volume. The mining for sparsebundle is wasteful.

```sh
[Global]
    spotlight = yes
    dbus daemon = /usr/bin/dbus-daemon

[Homes]
    basedir regex = /home

[Test Volume]
    path = /export/test1

[My Time Machine Volume]
    path = /export/timemachine
    time machine = yes
    spotlight = no
    vol size limit = 512000
```
