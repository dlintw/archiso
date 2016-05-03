# archtw
[archtw] is a customized Arch Linux Taiwanese friendly bootable disk.
Its features including
- Small and fit into RAM (minimum 512MB required)
- Gparted - a GUI for resizing partitions of disk
- xombrero - A minimalists web browser, vi-like but with traditional web 
  browser behavior.(F1 for more help)
- gcin - providing various Chinese input method
- almost all utility in Arch Linux standard install disk 

[archtw]是專為台灣使用者訂製的圖形化Arch Linux開機片.主要特色包含:
- 佔用空間小可完全在記憶體中運作（最少需要512MB)
- Gparted - 可用來分割重新調整磁碟機分區的工具
- xombrero - 精簡的瀏覽器, 具有兼具傳統滑鼠點選及類似 vi 按鍵操作介面(按F1看說明)
- xombrero - 精簡的a minimal browser
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
2. Format first partition as NTFS/FAT32 parition and label as *ARCH_TW*.  
  This is used as windows usb and bootable Linux partition.
3. Format second partition as ext4 linux partition and lable as *ARCH_COW*.
  This is used as 'Copy-On-Write' partition to keep your modification.

我們也可以使用 GRUB 來安裝, 這個方法比較好用.

1. 隨身碟分割為兩個分區
2. 將第一個分區格式化為 NTFS, 並將標籤定為 *ARCH_TW*
3. 將第二個分區格式化為 ext4, 並將標籤定為 *ARCH_COW*

```sh
# login root in Arch Linux
mkdir -p /mnt/sdb1
mount /dev/sdb1 /mnt/sdb1

# build from source
git clone https://github.com/dlintw/archiso
cd archiso
git checkout archtw # switch to archtw branch
cd configs/archtw
./build.sh -rrv  # full clean & rebuild

./inst_grub.sh sdb /mnt/sdb1
```
## Reference
- [archiso]

## Development

Following the [archiso] guide
```sh
git clone https://github.com/dlintw/archiso
cd archiso
git checkout archtw # switch to archtw branch
cd configs/archtw
# modification
./build.sh -rrv  # full clean & rebuild
```
Want to contribute? Welcome!

## Version/版本
2016.05.03 - First Release, 初次釋出

License
-------

GPL (Derived as same as archiso)

[archtw]: <https://github.com/dlintw/archiso>
[archiso]: <https://wiki.archlinux.org/index.php/Archiso>

[//]: # (
vim:et sw=2 ts=2 ai nocp sta
        )
