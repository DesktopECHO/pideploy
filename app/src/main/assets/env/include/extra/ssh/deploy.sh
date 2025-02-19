#!/bin/sh
# Pi Deploy Component
# (c) Anton Skshidlevsky <meefik@gmail.com>, GPLv3

[ -n "${SSH_PORT}" ] || SSH_PORT="22"

do_install()
{
    msg ":: Installing ${COMPONENT} ... "
    local packages=""
    case "${DISTRIB}:${ARCH}:${SUITE}" in
    debian:*|ubuntu:*|kali:*)
        packages="openssh-server"
        [ "${METHOD}" = "proot" ] && packages="${packages} fakechroot"
        apt_install ${packages}
    ;;
    archlinux:*)
        packages="openssh"
        pacman_install ${packages}
    ;;
    fedora:*)
        packages="openssh-server"
        dnf_install ${packages}
    ;;
    centos:*)
        packages="openssh-server"
        yum_install ${packages}
    ;;
    slackware:*)
        packages="openssh"
        slackpkg_install ${packages}
    ;;
    alpine:*)
        packages="openssh-server"
        apk_install ${packages}
    ;;
    esac
}

do_configure()
{
    msg ":: Configuring ${COMPONENT} ... "
    local sshd_config
    sshd_config="${CHROOT_DIR}/etc/ssh/sshd_config"
    sed -i -E 's/#?PasswordAuthentication .*/PasswordAuthentication yes/g' "${sshd_config}"
    sed -i -E 's/#?PermitRootLogin .*/PermitRootLogin yes/g' "${sshd_config}"
    sed -i -E 's/#?AcceptEnv .*/AcceptEnv LANG/g' "${sshd_config}"
    return 0
}

do_start()
{
    msg -n ":: Starting ${COMPONENT} ... "
    is_stopped /var/run/sshd.pid /run/sshd.pid || test $(pidof sshd) -eq 0
    is_ok "skip" || return 0
    make_dirs /run/sshd /var/run/sshd
    # generate keys
    if [ $(ls "${CHROOT_DIR}/etc/ssh/" | grep -c key) -eq 0 ]; then
        chroot_exec -u root ssh-keygen -A >/dev/null
    fi
    # exec sshd
    if [ "${METHOD}" = "proot" ]; then
        chroot_exec -u root fakechroot /usr/sbin/sshd -p ${SSH_PORT} ${SSH_ARGS} &
    else
        chroot_exec -u root /usr/sbin/sshd -p ${SSH_PORT} ${SSH_ARGS}
    fi
    is_ok "fail" "done"
    return 0
}

do_stop()
{
    msg -n ":: Stopping ${COMPONENT} ... "
    kill_pids /run/sshd.pid /var/run/sshd.pid
    is_ok "fail" "done"
    return 0
}

do_status()
{
    msg -n ":: ${COMPONENT} ... "
    is_started /var/run/sshd.pid /run/sshd.pid
    is_ok "stopped" "started"
    return 0
}

do_help()
{
cat <<EOF
   --ssh-port="${SSH_PORT}"
     Port of SSH server.

   --ssh-args="${SSH_ARGS}"
     Defines other sshd options, separated by a space.

EOF
}
