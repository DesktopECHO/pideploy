# Notice:

This repo contains the source code for the Pi Deploy APK installer (a fork of Linux Deploy.)

For the latest news, updates, and disk image releases, visit the [Pi-hole for Android](https://github.com/DesktopECHO/Pi-hole-for-Android) repository.

## Pi Deploy

Copyright (C) 2012-2019  Anton Skshidlevsky, [GPLv3](https://github.com/meefik/pideploy/blob/master/LICENSE)

This application is open source software for quick and easy installation of the operating system (OS) GNU/Linux on your Android device.

The application creates a disk image or a directory on a flash card or uses a partition or RAM, mounts it and installs an OS distribution. Applications of the new system are run in a chroot environment and working together with the Android platform. All changes made on the device are reversible, i.e. the application and components can be removed completely. Installation of a distribution is done by downloading files from official mirrors online over the internet. The application can run better with superuser rights (root).

The program supports multi language interface. You can manage the process of installing the OS, and after installation, you can start and stop services of the new system (there is support for running your scripts) through the UI. The installation process is reported as text in the main application window. During the installation, the program will adjust the environment, which includes the base system, SSH server, VNC server and desktop environment. The program interface can also manage SSH and VNC settings.

Installing a new operating system takes about 15 minutes. The recommended minimum size of a disk image is 1024 MB (with LXDE), and without a GUI - 512 MB. When you install Linux on the flash card with the FAT32 file system, the image size should not exceed 4095 MB! After the initial setup the password for SSH and VNC generated automatically. The password can be changed through "Properties -> User password" or standard OS tools (passwd, vncpasswd).

## Features

- Bootstrap: Debian or from rootfs.tar
- Installation type: image file, directory, disk partition, RAM
- Supported file systems: ext2, ext3, ext4
- Supported architectures: arm, arm64
- Supported languages: multilingual interface

Donations for LinuxDeploy:

- E-Money: <https://meefik.github.io/donate>
