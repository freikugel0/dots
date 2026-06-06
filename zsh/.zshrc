export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

plugins=(git vi-mode F-Sy-H)

source $ZSH/oh-my-zsh.sh

alias slock='slock -m "$(fortune | cowsay)"'

tmux() {
    TERM=xterm-kitty command tmux "$@"
}

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

unlock-sata() {
    local DEV="/dev/disk/by-partlabel/cryptpersonal"
    local MAP="personal"
    local MNT="/mnt/personal"

    doas cryptsetup open "$DEV" "$MAP" || return
    doas mount "/dev/mapper/$MAP" "$MNT"
}

conservation-mode() {
    local file="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
    [[ ! -f "$file" ]] && { echo "Error: File not found."; return 1; }

    if [[ $(cat "$file") == "0" ]]; then
        echo 1 | doas tee "$file" > /dev/null
        echo "Conservation mode: ON"
    else
        echo 0 | doas tee "$file" > /dev/null
        echo "Conservation mode: OFF"
    fi
}
