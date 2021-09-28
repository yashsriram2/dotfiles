# Config
* In file `/etc/systemd/logind.conf` set HandlePowerKey=ignore [for disabling immediate shutdown on power button press]
* enable `NetworkManager.service`
* use `.config/cronscripts/crontab` as crontab file and enable `cronie.service`

# Pacman
* in /etc/pacman.conf uncomment
  * VerbosePkgList
  * Color
* add a line in Misc options (for easter egg)
  * ILoveCandy

# TRIM for SSD
* To use TRIM (which is supported by linux out of the box) run
  * `sudo systemctl start fstrim.timer`
  * `sudo systemctl enable fstrim.timer`
* Why do trim? Read [this](https://blog.backslasher.net/linux-and-ssds-should-you-trim.html)
  * TL;DR because it improves life span

# intel powersaving
* add kernel parameters `enable_fbc=1 enable_psr=1` in `/etc/modprobe.d/i915.conf`
  * add line `options i915 enable_fbc=1 enable_psr=1` in `/etc/modprobe.d/i915.conf`

# X lockup
* add `acpi_osi=! acpi_osi=\"Windows 2009\"` to kernel parameters
  * i.e. in `/etc/default/grub` append to existing parameters `GRUB_CMDLINE_LINUX_DEFAULT="foo bar acpi_osi=! acpi_osi=\"Windows 2009\""`

# run on nvidia GPU (solely, no switching)
* update and upgrade
  * `sudo pacman -Syu`
  * installing updated nvidia driver with outdated linux kernel will not work
  * `https://github.com/archlinux/svntogit-packages/commits/packages/nvidia/trunk` provides mapping from kernel to driver version.
* install `nvidia` `nvidia-utils`
  * `sudo pacman -S nvidia nvidia-utils`
* prepend `xrandr --auto` to your xinitrc
  * after installing nvidia the output name of your inbuilt monitor according to xrandr may change
* add `nvidia-drm.modeset=1 rcutree.rcu_idle_gp_delay=1` as kernel parameters
  * in `/etc/default/grub` append to existing parameters `GRUB_CMDLINE_LINUX_DEFAULT="foo bar nvidia-drm.modeset=1 rcutree.rcu_idle_gp_delay=1"`
* add `nvidia, nvidia_modeset, nvidia_uvm and nvidia_drm` modules in mkinitcpio config file
  * in `/etc/mkinitcpio.conf` append to existing modules `MODULES=(foo bar nvidia nvidia_modeset nvidia_uvm nvidia_drm)`
* `sudo mkinitcpio -p linux`
* `sudo grub-mkconfig -o /boot/grub/grub.cfg`
* create a pacman hook `/etc/pacman.d/hooks/nvidia.hook` so that whenever nvidia driver gets updated mkinitcpio is executed
```
    [Trigger]
    Operation=Install
    Operation=Upgrade
    Operation=Remove
    Type=Package
    Target=nvidia

    [Action]
    Description=Update Nvidia module in initcpio
    Depends=mkinitcpio
    When=PostTransaction
    NeedsTargets
    Exec=/usr/bin/mkinitcpio -P
```
# run selected programs only on nvidia GPU (switching)
* follow instructions of above sections
* install `bumblebee` as described in the arch wiki page
  * install `bumblebee` `mesa` `xf86-video-intel`
  * add the user to group bumblebee `sudo gpasswd -a user bumblebee`
  * enable bumblebee service `sudo systemctl enable bumblebeed.service`
  * reboot
* by default everything is run using integrated GPU, to specify an application to run on nvidia GPU use
  * `optirun <program-name>`
