# Arch Linux Minimal Setup Notes (Dotfiles)

## Overview
This repository documents a custom Arch Linux minimal installation and user environment setup. The goal is to maintain a lightweight, modular, and suckless-oriented system built for daily development and terminal-centric workflows.

---

## System Stack (Base Installation)

- **Boot mode:** UEFI
- **Filesystem:** Btrfs with LUKS full disk encryption
- **Swap:** zram (with optional swap partition for compatibility; not used for hibernation due to sufficient RAM)
- **Bootloader:** systemd-boot with UKI-based boot process following Arch Wiki recommendations for Btrfs + LUKS
- **Audio stack:** PipeWire
- **Networking:** NetworkManager
- **Display server:** Xorg (chosen for maturity and compatibility with dwm-based workflow)
- **Kernel:**
  - linux (mainline fallback)
  - linux-zen (primary daily driver)
- **Power management:** auto-cpufreq
- **Bluetooth stack:** BlueZ with bluetuith frontend
- **Privilege management:**
  - doas (primary)
  - polkit (authentication agent)
  - sudo (legacy compatibility fallback)
- **Mirror management:** reflector-rs

---

## Post-Installation User Environment

- **Dotfiles management:** GNU Stow
- **Shell:** zsh + oh-my-zsh
- **Terminal multiplexer:** tmux + oh-my-tmux

### Xorg utilities
- xorg-server
- xorg-xinit
- xorg-xrandr
- xorg-xsetroot
- xorg-xinput
- xorg-xprop
- xorg-xkill
- xorg-xev
- xclip
- xsel

### Window management stack
- dwm (heavily patched)
- st (simple terminal)
- dmenu (application launcher)

Session is started using **startx only**, without a display manager.

---

## Xorg Configuration Tweaks

- Minimal Xorg tuning based on Arch Wiki tips & tricks
- Experimental driver configuration adjustments where applicable

---

## Desktop Utilities

- Notification daemon: dunst
- Wallpaper setter: feh
- Screenshot tools: maim + slop
- File manager: yazi
- USB automount: udiskie
- Browser: Helium

---

## XDG Base Directory Overrides

```bash
XDG_DESKTOP_DIR="$HOME"
XDG_TEMPLATES_DIR="$HOME"
XDG_PUBLICSHARE_DIR="$HOME"
XDG_DOCUMENTS_DIR="$HOME/docs"
XDG_DOWNLOAD_DIR="$HOME/downloads"
XDG_MUSIC_DIR="$HOME"
XDG_PICTURES_DIR="$HOME/pics"
XDG_VIDEOS_DIR="$HOME"
```

---

## dwm Customization Notes

- Keybindings are fully separated from dwm configuration and handled via `sxhkd`
- IPC patch is used to expose dwm control externally via CLI tooling
- Resulting architecture:
  - Cleaner `config.h`
  - Externalized keybinding system
  - Modular window manager control layer

This design improves maintainability and allows dynamic interaction with dwm without recompilation.

---

## Philosophy

This setup prioritizes:

- Minimalism over convenience bloat
- Explicit configuration over abstraction layers
- Modular UNIX-style tool composition
- Reproducibility via dotfiles
- Lightweight performance-oriented workflow

