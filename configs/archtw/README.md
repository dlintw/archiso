# archtw
[archtw] is a customized Arch Linux Taiwanese friendly bootable disk.
Its features including
- Small and fit into RAM (minimum 512MB required)
- Gparted - a GUI for resizing partitions of disk
- Chormium - Browser for internet access
- gcin - providing various Chinese input method
- almost all utility in Arch Linux standard install disk 

[archtw]是專為台灣使用者訂製的圖形化Arch Linux開機片.主要特色包含:
- 佔用空間小可完全在記憶體中運作（最少需要512MB)
- Gparted - 可用來分割重新調整磁碟機分區的工具
- Chromium - 上網瀏覽器
- gcin - 中文輸入
- 內含幾乎所有 Arch Linux 標準安裝光碟的工具

## Installation / 安裝

### syslinux method
This simple method will overwrite full usb stick.
這個簡單方法會覆寫整個隨身碟
```sh
dd if=archtw-<VERSION>.iso of=/dev/sdb bs=1M
```
### GRUB method
We can use GRUB as alternate method. This method is more powerful and useful.

1. Split the usb stick into two partitions. 
2. Format first partition as FAT32/NTFS parition and label as *ARCH_TW*.  
  This is used as windows usb and bootable Linux partition.
3. Format second partition as ext4 linux partition and lable as *ARCH_COW*.
  This is used as 'Copy-On-Write' partition to keep your modification.

我們也可以使用 GRUB 來安裝, 這個方法比較好用.

1. 隨身碟分割為兩個分區
2. 將第一個分區格式化為 FAT32, 並將標籤定為 *ARCH_TW*
3. 將第二個分區格式化為 ext4, 並將標籤定為 *ARCH_COW*

```sh
# login root in Arch Linux
mkdir -p /mnt/sdb1
mount /dev/sdb1 /mnt/sdb1

# install required packages
sudo pacman -S archiso

# build from source
git clone -b archtw https://github.com/dlintw/archiso
cd archiso
cd configs/archtw
sudo ./build.sh -rrv  # full clean & rebuild

sudo ./inst_grub.sh sdb /mnt/sdb1
```
## Usage / 使用

* 開機選單主要分兩大類:
 * i686 - 適用於較古老的主機
 * x86\_64 - 目前一般主機
* 每一大類分三種運作模式:
 * 一般: 作業系統放置於隨身碟，資料放在記憶體, 不可拔出隨身碟, 關機資料消失
 * RAM: 作業系統及資料都放在記憶體, 開機完可拔出隨身碟, 關機資料消失
 * RAM+COW: 作業系統至於隨身碟, 資料都放在隨身碟, 使用時不可拔出隨身碟
* 若可成功登入圖形介面, 不需輸入帳號
* 若無法登入圖形介面, 可按 Ctrl-Alt-F2, 登入帳號: arch 密碼: arch

## Reference
- [archiso]

## Development

Following the [archiso] guide
```sh
sudo pacman -S --needed mtools
git clone -b archtw https://github.com/dlintw/archiso
cd archiso
cd configs/archtw
# modification
./build.sh -rrv  # full clean & rebuild
```
Want to contribute? Welcome!

## Version/版本

- 2016.05.03 - First Release, 初次釋出
- 2016.05.05 - merged x86\_64 settings,  整合 x86\_64 設定
- 2016.05.07 - use chromium instead of xombrero(373M->438M), 改用chromium瀏覽器
- 2016.05.21:
  1. replace prebootloader by efitools
  2. move readme from upper directory to archtw directory

Known Problems
--------------

1. 無法重整 NTFS 磁區
 * A1. 目前 Linux 沒有好的工具可以修正 NTFS 的錯誤, 必須切回 Windows 修正, 因此
   不建議使用
2. 當 make grubiso 時, 失敗不會脫離
 * A2. rm work/build.make_grubiso_x86_64 再

License
-------

GPL (Derived as same as archiso)

[archtw]: <https://github.com/dlintw/archiso/tree/archtw>
[archiso]: <https://wiki.archlinux.org/index.php/Archiso>

[//]: # (
vim:et sw=2 ts=2 ai nocp sta
        )
