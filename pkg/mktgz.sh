#!/bin/bash
PKG="asciigames"
PKG_NAME="asciigames"
DESTDIR="usr/local"
ARCH=`uname -s`
SUDO=sudo
HERE=`pwd`
USER=`id -u -n`

[ "${USER}" == "root" ] && {
  echo "mktgz.sh must be run as a non-root user with sudo privilege"
  echo "Exiting"
  exit 1
}

[ -f VERSION ] || {
  echo "mktgz.sh must be run in the root of the asciigames source folder"
  echo "Exiting"
  exit 1
}

. ./VERSION
PKG_VER=${VERSION}
PKG_REL=${RELEASE}

umask 0022

# Subdirectory in which to create the distribution files
OUT_DIR="${HERE}/dist/${PKG_NAME}_${PKG_VER}"

# Build ninvaders
./build ninvaders

# Build tetris
./build tetris
strip tetris/tetris

${SUDO} rm -rf dist
mkdir dist

[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR}
mkdir ${OUT_DIR}

for dir in "usr" "${DESTDIR}" "${DESTDIR}/share" "${DESTDIR}/share/man" \
           "${DESTDIR}/share/doc" \
           "${DESTDIR}/share/doc/${PKG}" \
           "${DESTDIR}/share/${PKG}" "${DESTDIR}/games" "${DESTDIR}/games/bin" \
           "${DESTDIR}/games/lib" "${DESTDIR}/games/var" "${DESTDIR}/games/lib/ninvaders" \
           "${DESTDIR}/games/share" "${DESTDIR}/games/share/doc" \
           "${DESTDIR}/games/share/doc/tetris" \
           "${DESTDIR}/games/share/pixmaps" \
           "${DESTDIR}/games/share/applications"
do
    [ -d ${OUT_DIR}/${dir} ] || ${SUDO} mkdir ${OUT_DIR}/${dir}
    ${SUDO} chown root:wheel ${OUT_DIR}/${dir}
done

# Install ninvaders
cd ninvaders
${SUDO} chown root ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders
${SUDO} chgrp wheel ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders
${SUDO} chmod 0775 ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders
${SUDO} touch ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders/highscore
${SUDO} cp LICENSE ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders
${SUDO} cp README.md ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders
${SUDO} cp ChangeLog ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders
${SUDO} chown root ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders/highscore
${SUDO} chgrp wheel ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders/highscore
${SUDO} chmod 0664 ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders/*

${SUDO} cp cmake_build/ninvaders ${OUT_DIR}/${DESTDIR}/games/bin
${SUDO} chown root ${OUT_DIR}/${DESTDIR}/games/bin/ninvaders
${SUDO} chgrp wheel ${OUT_DIR}/${DESTDIR}/games/bin/ninvaders
${SUDO} chmod 02755 ${OUT_DIR}/${DESTDIR}/games/bin/ninvaders
${SUDO} ln -r -s ${OUT_DIR}/${DESTDIR}/games/bin/ninvaders ${OUT_DIR}/${DESTDIR}/games/ninvaders
${SUDO} gzip -9 ${OUT_DIR}/${DESTDIR}/games/lib/ninvaders/ChangeLog
cd ..

# Tetris
${SUDO} cp tetris/tetris ${OUT_DIR}/${DESTDIR}/games/bin
${SUDO} chown root ${OUT_DIR}/${DESTDIR}/games/bin/tetris
${SUDO} chgrp wheel ${OUT_DIR}/${DESTDIR}/games/bin/tetris
${SUDO} chmod 02755 ${OUT_DIR}/${DESTDIR}/games/bin/tetris
${SUDO} rm -f ${OUT_DIR}/${DESTDIR}/games/tetris
${SUDO} ln -r -s ${OUT_DIR}/${DESTDIR}/games/bin/tetris ${OUT_DIR}/${DESTDIR}/games/tetris
${SUDO} cp tetris/gameserver ${OUT_DIR}/${DESTDIR}/games/bin
${SUDO} chown root ${OUT_DIR}/${DESTDIR}/games/bin/gameserver
${SUDO} chgrp wheel ${OUT_DIR}/${DESTDIR}/games/bin/gameserver
${SUDO} chmod 02755 ${OUT_DIR}/${DESTDIR}/games/bin/gameserver
${SUDO} rm -f ${OUT_DIR}/${DESTDIR}/games/gameserver
${SUDO} ln -r -s ${OUT_DIR}/${DESTDIR}/games/bin/gameserver ${OUT_DIR}/${DESTDIR}/games/gameserver

${SUDO} cp tetris/licence.txt ${OUT_DIR}/${DESTDIR}/games/share/doc/tetris
${SUDO} cp tetris/README ${OUT_DIR}/${DESTDIR}/games/share/doc/tetris
${SUDO} cp tetris/INSTALL ${OUT_DIR}/${DESTDIR}/games/share/doc/tetris
${SUDO} cp tetris/tetris.xpm ${OUT_DIR}/${DESTDIR}/games/share/pixmaps
${SUDO} cp tetris/tetris.desktop ${OUT_DIR}/${DESTDIR}/games/share/applications
${SUDO} touch ${OUT_DIR}/${DESTDIR}/games/var/tetris-hiscores
${SUDO} chown root ${OUT_DIR}/${DESTDIR}/games/var/tetris-hiscores
${SUDO} chgrp wheel ${OUT_DIR}/${DESTDIR}/games/var/tetris-hiscores
${SUDO} chmod 0664 ${OUT_DIR}/${DESTDIR}/games/var/tetris-hiscores

${SUDO} cp README.md ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp copyright ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp VERSION ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp tetris/licence.txt ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/license-tetris
${SUDO} cp tetris/README ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/README-tetris

${SUDO} chmod 644 ${OUT_DIR}/${DESTDIR}/share/man/*/*
${SUDO} chmod 755 ${OUT_DIR}/${DESTDIR}/bin/* \
                  ${OUT_DIR}/${DESTDIR}/bin \
                  ${OUT_DIR}/${DESTDIR}/share/man \
                  ${OUT_DIR}/${DESTDIR}/share/man/*
find ${OUT_DIR}/${DESTDIR}/share/doc/${PKG} -type d | while read dir
do
  ${SUDO} chmod 755 "${dir}"
done
find ${OUT_DIR}/${DESTDIR}/share/doc/${PKG} -type f | while read f
do
  ${SUDO} chmod 644 "${f}"
done
find ${OUT_DIR}/${DESTDIR}/share/${PKG} -type d | while read dir
do
  ${SUDO} chmod 755 "${dir}"
done
find ${OUT_DIR}/${DESTDIR}/share/${PKG} -type f | while read f
do
  ${SUDO} chmod 644 "${f}"
done
${SUDO} chmod 775 ${OUT_DIR}/${DESTDIR}/games/var
${SUDO} chown -R root:wheel ${OUT_DIR}/${DESTDIR}

cd ${OUT_DIR}
echo "Creating compressed tar archive of ${PKG_NAME} ${PKG_VER} distribution"
${SUDO} tar cf - ${DESTDIR}/*/* | gzip -9 > ../${PKG_NAME}_${PKG_VER}-${PKG_REL}.${ARCH}.tgz

echo "Creating zip archive of ${PKG_NAME} ${PKG_VER} distribution"
${SUDO} zip -q -r ../${PKG_NAME}_${PKG_VER}-${PKG_REL}.${ARCH}.zip ${DESTDIR}/*/*

cd ..
[ -d ../releases ] || mkdir ../releases
[ -d ../releases/${PKG_VER} ] || mkdir ../releases/${PKG_VER}
${SUDO} cp *.tgz *.zip ../releases/${PKG_VER}
