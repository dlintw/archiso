#!/bin/bash
set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
#sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

#systemctl enable pacman-init.service choose-mirror.service
systemctl enable pacman-init.service
systemctl enable wicd
systemctl set-default multi-user.target

# Disable and remove the services created by archiso
systemctl disable choose-mirror.service || true
#rm -rf /etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount}
#rm -f /etc/systemd/scripts/choose-mirror

# use tw mirror ( because the mirrorlist will be overwrite by build.sh
#cp /etc/pacman.d/mirrorlist{.tw,}

## add 'arch' normal user
#sed -i 's/root/arch/' /etc/systemd/system/getty@tty1.service.d/autologin.conf || true
id arch || useradd -m -g users -s /usr/bin/zsh \
  -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" \
  arch

# use random number as 'arch' & 'root' password
echo "root:$RANDOM$RANDOM" | chpasswd
echo "arch:arch" | chpasswd

grep -q '^arch' /etc/sudoers || echo 'arch ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

cp -aT /etc/skel/ /home/arch
cp -aT /etc/home /home/arch
chown -R arch /home/arch


## reduce space
# remove seldom use packages

# remove binary file symbols
#pacman -S --needed --noconfirm binutils
strip /usr/bin/* | true

pacman -Rsn --noconfirm lxsession-gtk3 lxtask-gtk3 lxdm-gtk3 lxterminal-gtk3 \
  jfsutils mdadm nano reiserfsprogs xfsprogs \
  b43-fwcutter dmraid f2fs-tools fsarchiver irssi lftp linux-atm lsscsi \
  pptpclient rp-pppoe sg3_utils speedtouch wvdial zd1211-firmware \
  binutils

# remove documents
rm -rf /usr/share/{doc,man,info,html,sgml,gtk-doc,ri,help}
# some license file is required for build.sh
for d in /usr/share/locale/* ; do
  if [ -d $d ] ; then
    case $(basename $d) in
      zh_TW):;;
      *) rm -rf $d;;
    esac
  fi
done

# remove not use firmwares
for d in /usr/lib/firmware ; do
  if [ -d $d ]; then
    rm -rf $d
  elif [ -f $d ]; then
    case $(basename $d) in
      iwlwifi-3945-*.ucode):;;
      *) rm -f $d;;
    esac
  fi
done

# remove develop files
libdirs=/usr/lib
[ -d /usr/local/lib ] && libdirs="/usr/local/lib $libdirs"
for i in /usr/include /usr/lib/pkgconfig /usr/share/aclocal\
  /usr/share/gettext /usr/bin/*-config \
  /usr/share/vala/vapi /usr/share/gir-[0-9]* \
  /usr/share/qt*/mkspecs \
  /usr/lib/qt*/mkspecs \
  /usr/lib/cmake \
  $(find / -name include -type d) \
  $(find $libdirs -name '*.[acho]' -o -name '*.prl' 2>/dev/null); do
  rm -rf $i
done


# vim:et sw=2 ts=2 ai nocp sta
