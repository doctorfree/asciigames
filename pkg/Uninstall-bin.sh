#!/bin/bash

ASCGME_DIRS="/usr/local/games/share/doc/nethack \
/usr/local/games/share/doc/tetris \
/usr/local/games/share/nethack \
/usr/local/games/var/nethack \
/usr/local/share/asciigames \
/usr/local/share/doc/asciigames"

ASCGME_FILES="/usr/local/games/bin/gameserver \
/usr/local/games/bin/nethack \
/usr/local/games/bin/tetris \
/usr/local/games/gameserver \
/usr/local/games/nethack \
/usr/local/games/share/applications/tetris.desktop \
/usr/local/games/share/pixmaps/tetris.xpm \
/usr/local/games/tetris \
/usr/local/games/var/tetris-hiscores \
/usr/local/share/man/man6/dgn_comp.6 \
/usr/local/share/man/man6/dlb.6 \
/usr/local/share/man/man6/lev_comp.6 \
/usr/local/share/man/man6/nethack.6 \
/usr/local/share/man/man6/recover.6"

user=`id -u -n`

[ "${user}" == "root" ] || {
  echo "Uninstall-bin.sh must be run as the root user."
  echo "Use 'sudo ./Uninstall-bin.sh ...'"
  echo "Exiting"
  exit 1
}

rm -f ${ASCGME_FILES}
rm -rf ${ASCGME_DIRS}
