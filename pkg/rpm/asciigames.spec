Name: asciigames
Version:    %{_version}
Release:    %{_release}
BuildArch:  x86_64
Requires: util-linux, ncurses
URL:        https://github.com/doctorfree/asciigames
Vendor:     Doctorwhen's Bodacious Laboratory
Packager:   ronaldrecord@gmail.com
# Nethack is licensed under the Nethack General Public License,
# Tetris is MIT licensed, Ninvaders is GPLv2
License: Nethack General Public License and GPLv2 and MIT
Summary     : ASCII Games

%global __os_install_post %{nil}

%description

%prep

%build

%install
cp -a %{_sourcedir}/usr %{buildroot}/usr

%pre

%post

%preun

%files
%defattr(-,root,root)
%attr(4755, games, games) /usr/games/bin/*
%attr(0664, games, games) /usr/games/var/tetris-hiscores
%attr(0755, games, games) /usr/games/var/nethack/bones
%attr(0755, games, games) /usr/games/var/nethack/level
%attr(0755, games, games) /usr/games/var/nethack/saves
%attr(0644, games, games) /usr/games/var/nethack/logfile
%attr(0644, games, games) /usr/games/var/nethack/perm
%attr(0644, games, games) /usr/games/var/nethack/record
%attr(0644, games, games) /usr/games/var/nethack/xlogfile
%attr(0644, games, games) /usr/games/lib/ninvaders/*
%exclude %dir /usr/share/man/man6
%exclude %dir /usr/share/man
%exclude %dir /usr/share/doc
%exclude %dir /usr/share
%exclude %dir /usr/games
%exclude %dir /usr/games/bin
%exclude %dir /usr/games/lib
%exclude %dir /usr/games/share
%exclude %dir /usr/games/var
/usr/share/*
/usr/games/2048
/usr/games/gameserver
/usr/games/nethack
/usr/games/ninvaders
/usr/games/palette
/usr/games/tetris
/usr/games/share/*

%changelog
