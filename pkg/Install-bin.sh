#!/bin/bash

usage() {
  echo "Usage: sudo ./Install-bin.sh /path/to/asciigames_<version>-<release>.<arch>.<suffix>"
  echo "Where:"
  printf "\n\t<suffix> can be a gzip'd tar archive with filename suffix 'tgz'"
  printf "\n\t\tor a zip archive with filename suffix 'zip'\n"
  echo "Download the latest gzip'd or zip'd binary distribution archive at"
  echo "https://github.com/doctorfree/asciigames/releases"
  exit 1
}

user=`id -u -n`

[ "${user}" == "root" ] || {
  echo "Install-bin.sh must be run as the root user."
  echo "Use 'sudo ./Install-bin.sh ...'"
  echo "Exiting"
  exit 1
}

[ "$1" ] || {
  echo "Install-bin.sh requires a pathname argument specifying"
  echo "the distribution archive to extract and install."
  echo "No argument provided."
  usage
}

[ -f "$1" ] || {
  echo "Install-bin.sh requires a pathname argument specifying"
  echo "the distribution archive to extract and install."
  echo "$1 does not exist or is not a plain file."
  usage
}

PATH_TO_ARCHIVE="$1"
ARCHIVE=`basename "${PATH_TO_ARCHIVE}"`
pkgname=`echo ${ARCHIVE} | awk -F '_' '{ print $1 }'`

[ "${pkgname}" == "asciigames" ] || {
  echo "Distribution archive filename must be of the format:"
  printf "\n\tasciigames_<version>-<release>.<arch>.<suffix>\n"
  echo "Distribution archive filename ${ARCHIVE} does not begin with 'asciigames'"
  usage
}

pkgvra=`echo ${ARCHIVE} | awk -F '-' '{ print $1 }'`
pkgver=`echo ${pkgvra} | awk -F '_' '{ print $2 }'`
pkgrag=`echo ${ARCHIVE} | awk -F '-' '{ print $2 }'`
pkgrel=`echo ${pkgrag} | awk -F '.' '{ print $1 }'`
pkgarc=`echo ${pkgrag} | awk -F '.' '{ print $2 }'`
pkgsuf=`echo ${pkgrag} | awk -F '.' '{ print $3 }'`

echo "Preparing to install ${pkgname} Version ${pkgver} Release ${pkgrel}"
echo "for architecture ${pkgarc}"
echo ""
echo "This installation method is recommended only if your system is not"
echo "supported by one of the packaged installation formats (Debian/RPM)"
echo "available at https://github.com/doctorfree/asciigames/releases"
echo ""
while true
do
  read -p "Proceed with installation? (y/n) " answer
  case ${answer} in
    [Yy]* )
      printf "\nProceeding with installation.\n"
      break
      ;;
    [Nn]* )
      printf "\nSkipping installation.\n"
      exit 1
      ;;
    * ) echo "Please answer 'y' to install, or 'n' to exit."
      ;;
  esac
done

unzip_inst=`type -p unzip`
if [ "${pkgsuf}" == "tgz" ]
then
  tar -mxzf ${PATH_TO_ARCHIVE} -C /
else
  if [ "${pkgsuf}" == "zip" ]
  then
    [ "${unzip_inst}" ] || {
      echo "The 'unzip' utility is not installed or not in the execution path"
      echo "Install-bin.sh requires 'unzip' to install a 'zip' archive"
      usage
    }
    unzip ${PATH_TO_ARCHIVE} –d /
  else
    echo "Unrecognized filename suffix '${pkgsuf}'"
    echo "Install-bin.sh requires a filename suffix of 'tgz' or 'zip'"
    usage
  fi
fi

echo "Installation of ${pkgname} Version ${pkgver} Release ${pkgrel}"
echo "for architecture ${pkgarc} complete."

exit 0
