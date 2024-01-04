#!/bin/sh
# Pi Deploy Component
# (c) Anton Skshidlevsky <meefik@gmail.com>, GPLv3

do_install()
{
    msg ":: Installing ${COMPONENT} ... "
    local packages=""
    case "${DISTRIB}:${ARCH}:${SUITE}" in
    debian:*|ubuntu:*|kali:*)
        packages="hostname"
    ;;
    archlinux:*)
        packages="hostname"
        pacman_install ${packages}
    ;;
    fedora:*)
        packages="hostname"
        dnf_install ${packages}
    ;;
    centos:*)
        packages="hostname"
        yum_install ${packages}
    ;;
    slackware:*)
        packages="hostname"
        slackpkg_install ${packages}
    ;;
    alpine:*)
        packages="hostname"
        apk_install ${packages}
    ;;
    esac
}
do_configure()
{
    msg ":: Configuring ${COMPONENT} ... "
    echo ${HOST_NAME} > "${CHROOT_DIR}/etc/hostname"
    return 0
}

do_start()
{
    msg -n ":: Starting ${COMPONENT} ... "
    chroot_exec -u ${USER_NAME} hostname ${HOST_NAME}
    is_ok "fail" "done"
    return 0
}

do_stop()
{
    msg -n ":: Stopping ${COMPONENT} ... "
    chroot_exec -u ${USER_NAME} hostname localhost
    is_ok "fail" "done"
    return 0
}
