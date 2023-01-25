# Ascii Games

The `asciigames` project provides several precompiled and prepackaged
open source character based Ascii games. These can be installed as standalone
packages on Linux and macOS or installed via the
[Asciiville project](https://github.com/doctorfree/Asciiville#readme)
initialization process.

Games currently included in this project:

* [Nethack](https://en.wikipedia.org/wiki/NetHack), ASCII text dungeon game
* [Ninvaders](https://en.wikipedia.org/wiki/Space_Invaders), ASCII text version of Space Invaders
* [Tetris](https://en.wikipedia.org/wiki/Tetris), ASCII text version of Tetris

## Table of Contents

1. [Requirements](#requirements)
1. [Installation](#installation)
1. [Removal](#removal)
1. [Building asciigames from source](#building-asciigames-from-source)
1. [Contributing](#contributing)

## Requirements

Asciigames is compiled and packaged for installation on:

- Arch Linux (x86_64)
- Fedora Linux (x86_64)
- Raspberry Pi OS (armhf)
- Ubuntu Linux (amd64)

## Installation

Download the [latest Arch, Debian, or RPM package format release](https://github.com/doctorfree/asciigames/releases) for your platform. If your platform does not support Arch, Debian, or RPM format installs then download the compressed binary distribution archive for your platform and the `Install-bin.sh` script.

### Supported platforms

Asciigames has been tested successfully on the following platforms:

- **Arch Linux 2022.07.01**
    - `asciigames_<version>-<release>-x86_64.pkg.tar.zst`
- **Ubuntu Linux 20.04**
    - `asciigames_<version>-<release>.amd64.deb`
- **Fedora Linux 36**
    - `asciigames_<version>-<release>.x86_64.rpm`
- **Raspberry Pi OS**
    - `asciigames_<version>-<release>.armhf.deb`

### Arch Linux based installation

Arch Linux, Manjaro, and other Arch Linux derivatives use the Pacman packaging
format. In addition to Arch Linux, Arch based Linux distributions include
ArchBang, Arch Linux, Artix Linux, ArchLabs, Asahi Linux, BlackArch,
Chakra Linux, EndeavourOS, Frugalware Linux, Garuda Linux,
Hyperbola GNU/Linux-libre, LinHES, Manjaro, Parabola GNU/Linux-libre,
SteamOS, and SystemRescue.

Install the package on Arch Linux based systems by executing the command:

```shell
sudo pacman -U ./asciigames_1.0.1-1-x86_64.pkg.tar.zst
```

### Debian based installation

Many Linux distributions, most notably Ubuntu and its derivatives, use the
Debian packaging system.

To tell if a Linux system is Debian based it is usually sufficient to
check for the existence of the file `/etc/debian_version` and/or examine the
contents of the file `/etc/os-release`.

Install the package on Debian based systems by executing the commands:

```shell
sudo apt update -y
sudo apt install ./asciigames_1.0.1-1.amd64.deb
```

or, on a Raspberry Pi:

```shell
sudo apt update -y
sudo apt install ./asciigames_1.0.1-1.armhf.deb
```

### RPM based installation

Red Hat Linux, SUSE Linux, and their derivatives use the RPM packaging
format. RPM based Linux distributions include Fedora, AlmaLinux, CentOS,
openSUSE, OpenMandriva, Mandrake Linux, Red Hat Linux, and Oracle Linux.

Install the package on RPM based systems by executing the command
```shell
sudo dnf update -y
sudo dnf localinstall ./asciigames-1.0.1-1.x86_64.rpm
```

### Manual installation

On systems for which the Arch, Debian, or RPM packages will not suffice, install manually by downloading the `Install-bin.sh` script and either the gzip'd distribution archive or the zip'd distribution archive.  After downloading the installation script and distribution archive, as a user with sudo privilege execute the commands:

```shell
chmod 755 Install-bin.sh
sudo ./Install-bin.sh /path/to/asciigames_1.0.1-1.<arch>.tgz
or
sudo ./Install-bin.sh /path/to/asciigames_1.0.1-1.<arch>.zip
```

## Removal

Removal of the package on Arch Linux based systems can be accomplished by issuing the command:

```shell
sudo pacman -Rs asciigames
```

Removal of the package on Debian based systems can be accomplished by issuing the command:

```shell
sudo apt remove asciigames
```

Removal of the package on RPM based systems can be accomplished by issuing the command:

```shell
sudo dnf remove asciigames
```

On systems for which the manual installation was performed using the `Install-bin.sh` script, remove Btop manually by downloading the `Uninstall-bin.sh` script and, as a user with sudo privilege, execute the commands:

```shell
chmod 755 Uninstall-bin.sh
sudo ./Uninstall-bin.sh
```

## Building asciigames from source

Asciigames can be compiled, packaged, and installed from the source code
repository. This should be done as a normal user with `sudo` privileges:

```
# Retrieve the source code from the repository
git clone https://github.com/doctorfree/asciigames.git
# Enter the asciigames source directory
cd asciigames
# Compile the asciigames components and create an installation package
./mkpkg
# Install asciigames and its dependencies
./Install
```

These steps are detailed below.

### Clone asciigames repository

```
git clone https://github.com/doctorfree/asciigames.git
cd asciigames
```

**[Note:]** The `mkpkg` script in the top level of the asciigames
repository can be used to build an installation package on all supported
platforms. After cloning, `cd asciigames` and `./mkpkg`. The resulting
installation package(s) will be found in `./releases/<version>/`.

### Install packaging dependencies

asciigames components have packaging dependencies on the following:

On Debian based systems like Ubuntu Linux, install packaging dependencies via:

```
sudo apt install dpkg
```

On RPM based systems like Fedora Linux, install packaging dependencies via:

```
sudo dnf install rpm-build rpm-devel rpmlint rpmdevtools
```

### Build and package asciigames

To build and package asciigames, execute the command:

```
./mkpkg
```

On Debian based systems like Ubuntu Linux, the `mkpkg` scripts executes
`scripts/mkdeb.sh`.

On RPM based systems like Fedora Linux, the `mkpkg` scripts executes
`scripts/mkrpm.sh`.

On PKGBUILD based systems like Arch Linux, the `mkpkg` scripts executes
`scripts/mkaur.sh`.

### Install asciigames from source build

After successfully building and packaging asciigames with either
`./mkpkg`, install the asciigames package with the command:

```
./Install
```

## Contributing

There are a variety of ways to contribute to the asciigames project.
All forms of contribution are appreciated and valuable. Also, it's fun to
collaborate. Here are a few ways to contribute to the further improvement
and evolution of asciigames:

### Testing and Issue Reporting

asciigames is fairly complex with many components, features, options,
configurations, and use cases. Although currently only supported on
Linux platforms, there are a plethora of Linux platforms on which
asciigames can be deployed. Testing all of the above is time consuming
and tedious. If you have a Linux platform on which you can install
asciigames and you have the time and will to put it through its paces,
then issue reports on problems you encounter would greatly help improve the
robustness and quality of asciigames. Open issue reports at
[https://github.com/doctorfree/asciigames/issues](https://github.com/doctorfree/asciigames/issues)

### Sponsor asciigames

asciigames is completely free and open source software. All of the
asciigames components are freely licensed and may be copied, modified,
and redistributed freely. Nobody gets paid, nobody is making any money,
it's a project fully motivated by curiousity and love of music. However,
it does take some money to procure development and testing resources.
Right now asciigames needs a multi-boot test platform to extend support
to a wider variety of Linux platforms and potentially Mac OS X.

If you have the means and you would like to sponsor asciigames development,
testing, platform support, and continued improvement then your monetary
support could play a very critical role. A little bit goes a long way
in asciigames. For example, a bootable USB SSD device could serve as a 
means of porting and testing support for additional platforms. Or, a
decent cup of coffee could be the difference between a bug filled
release and a glorious musical adventure.

Sponsor the asciigames project at
[https://github.com/sponsors/doctorfree](https://github.com/sponsors/doctorfree)

### Contribute to Development

If you have programming skills and find the management and ease-of-use of
digital music libraries to be an interesting area, you can contribute to
asciigames development through the standard Github "fork, clone,
pull request" process. There are many guides to contributing to Github hosted
open source projects on the Internet. A good one is available at
[https://www.dataschool.io/how-to-contribute-on-github/](https://www.dataschool.io/how-to-contribute-on-github/). Another short succinct guide is at
[https://gist.github.com/MarcDiethelm/7303312](https://gist.github.com/MarcDiethelm/7303312).

Once you have forked and cloned the asciigames repository, it's time to
setup a development environment. Although some of the asciigames commands
are Bash shell scripts, there are also applicatons written in C and C++ along
with documentation in Markdown format, configuration files in a variety of
formats, examples, screenshots, video demos, build scripts, packaging, and more.

To compile `asciigames` from source, run the command:

```
./build
```

On Debian (e.g. Ubuntu), PKGBUILD (e.g. Arch) and RPM (e.g. Fedora) based
systems the asciigames installation package can be created with the
`mkpkg` scripts. The `mkpkg` script determines which platform it is on
and executes the appropriate build and packaging script in the `scripts/`
directory. These scripts invoke the build scripts for each of the projects
included with asciigames, populate a distribution tree, and call the
respective packaging utilities. Packages are saved in the
`./releases/<version>/` folder. Once a package has been created
it can be installed with the `Install` script.

Feel free to email me at github@ronrecord.com with questions or comments.
