# dotfiles

Personal config for Arch + Hyprland, managed with [chezmoi](https://chezmoi.io).
Only the configs that are actually hand-maintained are tracked here — no app
caches, credentials, or generated state.

## Fresh machine bootstrap

```sh
# 1. base system + this repo
sudo pacman -S --needed git chezmoi
chezmoi init --apply git@github.com:4yourztruly/dotfiles.git

# 2. packages
sudo pacman -S --needed - < ~/.local/share/chezmoi/packages/pacman.txt

# 3. AUR packages (needs an AUR helper; installs yay first if missing)
pacman -Qi yay &>/dev/null || {
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
}
yay -S --needed - < ~/.local/share/chezmoi/packages/aur.txt

# 4. set fish as your login shell (chezmoi apply already dropped its config)
chsh -s /usr/bin/fish
```

That's it — `chezmoi apply` already symlinked everything into place in step 1.

## What's tracked

- `~/.config/hypr/` — Hyprland (`hyprland.lua`, new Lua config format as of
  Hyprland 0.55+), hyprlock, hyprpaper
- `~/.config/waybar`, `wofi`, `wlogout` — bar/launcher/logout menu
- `~/.config/kitty`, `~/.config/nvim` (LazyVim), `~/.config/fish`
- `~/.config/starship.toml`, `~/.config/mimeapps.list`, `~/.config/flameshot`,
  `~/.config/neofetch`
- `~/.bashrc`, `~/.gitconfig`
- `~/scripts/` — helper scripts referenced by Hyprland keybinds
- `packages/pacman.txt`, `packages/aur.txt` — explicitly-installed package
  lists (`pacman -Qqe` / `pacman -Qqem`), so a fresh install can restore the
  same package set

Deliberately **not** tracked: anything under app data dirs that's cache,
history, or credentials (Discord, Cursor/Code, GitKraken, Spotify, qBittorrent,
Proton, browser profiles, etc.) — none of that belongs in a "clean slate" repo.

## Making changes

```sh
chezmoi edit ~/.config/hypr/hyprland.lua   # edit via chezmoi (or just edit the real file)
chezmoi add ~/.config/some/new/file        # start tracking a new file
chezmoi diff                               # see what would change
chezmoi apply                              # apply source -> home
cd ~/.local/share/chezmoi && git add -A && git commit -m "..." && git push
```
