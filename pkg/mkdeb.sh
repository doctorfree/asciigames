#!/bin/bash
PKG="asciigames"
SRC_NAME="asciigames"
PKG_NAME="asciigames"
DEBFULLNAME="Ronald Record"
DEBEMAIL="ronaldrecord@gmail.com"
DESTDIR="usr"
SRC=${HOME}/src
ARCH=amd64
SUDO=sudo
GCI=

dpkg=`type -p dpkg-deb`
[ "${dpkg}" ] || {
    echo "Debian packaging tools do not appear to be installed on this system"
    echo "Are you on the appropriate Linux system with packaging requirements ?"
    echo "Exiting"
    exit 1
}

dpkg_arch=`dpkg --print-architecture`
[ "${dpkg_arch}" == "${ARCH}" ] || ARCH=${dpkg_arch}

[ -f "${SRC}/${SRC_NAME}/VERSION" ] || {
  [ -f "/builds/doctorfree/${SRC_NAME}/VERSION" ] || {
    echo "$SRC/$SRC_NAME/VERSION does not exist. Exiting."
    exit 1
  }
  SRC="/builds/doctorfree"
  GCI=1
# SUDO=
}

. "${SRC}/${SRC_NAME}/VERSION"
PKG_VER=${VERSION}
PKG_REL=${RELEASE}

umask 0022

# Subdirectory in which to create the distribution files
OUT_DIR="${SRC}/${SRC_NAME}/dist/${PKG_NAME}_${PKG_VER}"

[ -d "${SRC}/${SRC_NAME}" ] || {
    echo "$SRC/$SRC_NAME does not exist or is not a directory. Exiting."
    exit 1
}

cd "${SRC}/${SRC_NAME}"

# Build nethack
if [ -x build ]
then
  ./build nethack
else
  cd nethack
  ./configure --prefix=/usr/games \
              --with-owner=games \
              --with-group=games \
              --enable-wizmode=doctorwhen
  make
  cd ..
fi

# Build tetris
if [ -x build ]
then
  ./build tetris
else
  cd tetris
  [ -f tetris ] || {
    ./configure.sh --prefix=/usr/games --enable-xlib=no --enable-curses=yes
    make
    make gameserver
  }
  cd ..
fi

${SUDO} rm -rf dist
mkdir dist

[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR}
mkdir ${OUT_DIR}
cp -a pkg/debian ${OUT_DIR}/DEBIAN
chmod 755 ${OUT_DIR} ${OUT_DIR}/DEBIAN ${OUT_DIR}/DEBIAN/*

echo "Package: ${PKG}
Version: ${PKG_VER}-${PKG_REL}
Section: misc
Priority: optional
Architecture: ${ARCH}
Depends: uuid-runtime, libncurses-dev
Maintainer: ${DEBFULLNAME} <${DEBEMAIL}>
Installed-Size: 12000
Build-Depends: debhelper (>= 11)
Homepage: https://github.com/doctorfree/asciigames
Description: Console/Terminal Ascii Games" > ${OUT_DIR}/DEBIAN/control

chmod 644 ${OUT_DIR}/DEBIAN/control

for dir in "usr" "${DESTDIR}" "${DESTDIR}/share" "${DESTDIR}/share/man" \
           "${DESTDIR}/share/doc" \
           "${DESTDIR}/share/doc/${PKG}" \
           "${DESTDIR}/share/${PKG}" "${DESTDIR}/games" "${DESTDIR}/games/bin" \
           "${DESTDIR}/games/lib" \
           "${DESTDIR}/games/share" "${DESTDIR}/games/share/doc" \
           "${DESTDIR}/games/share/doc/tetris" \
           "${DESTDIR}/games/share/pixmaps" \
           "${DESTDIR}/games/share/applications"
do
    [ -d ${OUT_DIR}/${dir} ] || ${SUDO} mkdir ${OUT_DIR}/${dir}
    ${SUDO} chown root:root ${OUT_DIR}/${dir}
done

# Revised NetHack install using UnNetHack mods
cd nethack
${SUDO} make DESTDIR=${OUT_DIR} install
${SUDO} cp dat/license ${OUT_DIR}/${DESTDIR}/games/share/nethack/license
cd doc
${SUDO} make DESTDIR=${OUT_DIR} manpages
${SUDO} chown games ${OUT_DIR}/${DESTDIR}/games/bin/nethack
${SUDO} chgrp games ${OUT_DIR}/${DESTDIR}/games/bin/nethack
${SUDO} chmod 04755 ${OUT_DIR}/${DESTDIR}/games/bin/nethack
${SUDO} rm -f ${OUT_DIR}/${DESTDIR}/games/nethack
${SUDO} ln -r -s ${OUT_DIR}/${DESTDIR}/games/bin/nethack ${OUT_DIR}/${DESTDIR}/games/nethack
cd ..

# Tetris
${SUDO} cp tetris/tetris ${OUT_DIR}/${DESTDIR}/games/bin
${SUDO} chown games ${OUT_DIR}/${DESTDIR}/games/bin/tetris
${SUDO} chgrp games ${OUT_DIR}/${DESTDIR}/games/bin/tetris
${SUDO} chmod 04755 ${OUT_DIR}/${DESTDIR}/games/bin/tetris
${SUDO} rm -f ${OUT_DIR}/${DESTDIR}/games/tetris
${SUDO} ln -r -s ${OUT_DIR}/${DESTDIR}/games/bin/tetris ${OUT_DIR}/${DESTDIR}/games/tetris
${SUDO} cp tetris/gameserver ${OUT_DIR}/${DESTDIR}/games/bin
${SUDO} chown games ${OUT_DIR}/${DESTDIR}/games/bin/gameserver
${SUDO} chgrp games ${OUT_DIR}/${DESTDIR}/games/bin/gameserver
${SUDO} chmod 04755 ${OUT_DIR}/${DESTDIR}/games/bin/gameserver
${SUDO} rm -f ${OUT_DIR}/${DESTDIR}/games/gameserver
${SUDO} ln -r -s ${OUT_DIR}/${DESTDIR}/games/bin/gameserver ${OUT_DIR}/${DESTDIR}/games/gameserver

${SUDO} cp tetris/licence.txt ${OUT_DIR}/${DESTDIR}/games/share/doc/tetris
${SUDO} cp tetris/README ${OUT_DIR}/${DESTDIR}/games/share/doc/tetris
${SUDO} cp tetris/INSTALL ${OUT_DIR}/${DESTDIR}/games/share/doc/tetris
${SUDO} cp tetris/tetris.xpm ${OUT_DIR}/${DESTDIR}/games/share/pixmaps
${SUDO} cp tetris/tetris.desktop ${OUT_DIR}/${DESTDIR}/games/share/applications
${SUDO} touch ${OUT_DIR}/${DESTDIR}/games/var/tetris-hiscores
${SUDO} chown games ${OUT_DIR}/${DESTDIR}/games/var/tetris-hiscores
${SUDO} chgrp games ${OUT_DIR}/${DESTDIR}/games/var/tetris-hiscores
${SUDO} chmod 0664 ${OUT_DIR}/${DESTDIR}/games/var/tetris-hiscores

${SUDO} cp README.md ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp VERSION ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp games/tetris/licence.txt ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/license-tetris
${SUDO} cp games/tetris/README ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/README-tetris

${SUDO} cp games/nethack/dat/license ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/LICENSE-nethack
${SUDO} cp games/nethack/README ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/README-nethack

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
${SUDO} chown -R root:root ${OUT_DIR}/${DESTDIR}/share
${SUDO} chown -R root:root ${OUT_DIR}/${DESTDIR}/bin
${SUDO} chown -R games:games ${OUT_DIR}/${DESTDIR}/games/var

cd dist
echo "Building ${PKG_NAME}_${PKG_VER} Debian package"
${SUDO} dpkg --build ${PKG_NAME}_${PKG_VER} ${PKG_NAME}_${PKG_VER}-${PKG_REL}.${ARCH}.deb
cd ${PKG_NAME}_${PKG_VER}
echo "Creating compressed tar archive of ${PKG_NAME} ${PKG_VER} distribution"
${SUDO} tar cf - usr/*/* | gzip -9 > ../${PKG_NAME}_${PKG_VER}-${PKG_REL}.${ARCH}.tgz

have_zip=`type -p zip`
[ "${have_zip}" ] || {
  ${SUDO} apt-get update
  ${SUDO} apt-get install zip -y
}
echo "Creating zip archive of ${PKG_NAME} ${PKG_VER} distribution"
${SUDO} zip -q -r ../${PKG_NAME}_${PKG_VER}-${PKG_REL}.${ARCH}.zip usr/*/*
cd ..

[ "${GCI}" ] || {
  [ -d ../releases ] || mkdir ../releases
  [ -d ../releases/${PKG_VER} ] || mkdir ../releases/${PKG_VER}
  ${SUDO} cp *.deb *.tgz *.zip ../releases/${PKG_VER}
}