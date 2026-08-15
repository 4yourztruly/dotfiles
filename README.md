# dotfiles

Personal config for Arch + Hyprland, managed with [chezmoi](https://chezmoi.io).
Only the configs that are actually hand-maintained are tracked here — no app
caches, credentials, or generated state.

## Fresh machine bootstrap

One line, on a bare Arch install:

```sh
sudo pacman -S --needed --noconfirm git curl && sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply 4yourztruly
```

This installs chezmoi, clones this repo, symlinks every tracked config into
place, then automatically runs `.chezmoiscripts/run_onchange_before_install-packages.sh.tmpl`,
which:

1. installs everything in `packages/pacman.txt`
2. installs `yay` if it's missing, then everything in `packages/aur.txt`
3. sets `fish` as your login shell

That script re-runs on any future `chezmoi apply` if either package list
changes, so adding a package to `packages/pacman.txt` and pushing is enough —
no separate install step needed on machines that already have the repo.

Log out/in once afterwards to pick up the fish shell change.

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
