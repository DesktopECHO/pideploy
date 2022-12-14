#!/bin/sh
# Pi Deploy Component
# (c) Anton Skshidlevsky <meefik@gmail.com>, GPLv3

[ -n "${LOCALE}" ] || LOCALE="${LANG}"
[ -n "${LOCALE}" ] || LOCALE="C"

do_configure()
{
    msg ":: Configuring ${COMPONENT} ... "
    if $(echo ${LOCALE} | grep -q '\.'); then
        local inputfile=$(echo ${LOCALE} | awk -F. '{print $1}')
        local charmapfile=$(echo ${LOCALE} | awk -F. '{print $2}')
        chroot_exec -u root localedef -i ${inputfile} -c -f ${charmapfile} ${LOCALE}
    fi
    case "${DISTRIB}" in
    debian|ubuntu|kali)
        echo "LANG=${LOCALE}" > "${CHROOT_DIR}/etc/default/locale"
    ;;
    archlinux|centos)
        echo "LANG=${LOCALE}" > "${CHROOT_DIR}/etc/locale.conf"
    ;;
    fedora)
        echo "LANG=${LOCALE}" > "${CHROOT_DIR}/etc/sysconfig/i18n"
    ;;
    slackware)
        sed -i "s|^export LANG=.*|export LANG=${LOCALE}|g" "${CHROOT_DIR}/etc/profile.d/lang.sh"
    ;;
    alpine)
      echo "LANG=${LOCALE}" > "${CHROOT_DIR}/etc/profile.d/lang.sh"
    ;;
    esac
    return 0
}

do_help()
{
cat <<EOF
   --locale="${LOCALE}"
     Localization, e.g. "en_US.UTF-8".

EOF
}
