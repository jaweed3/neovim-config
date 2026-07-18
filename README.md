# neovim-config

Personal Neovim + dotfiles config managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Quick install (auto)

```bash
git clone <repo-url> ~/.config/nvim
~/.config/nvim/setup.sh
```

Script handles: system packages (+ build tools), Rust, Bun, yay (Arch), Nerd Font, chsh to zsh, symlink dotfiles to `~/`, tmux TPM, backup existing files.

### Skip sections

```bash
~/.config/nvim/setup.sh --skip-deps --skip-rust --skip-bun --skip-font --skip-chsh
```

Options: `--skip-deps` `--skip-link` `--skip-tpm` `--skip-rust` `--skip-bun` `--skip-opencode` `--skip-grok` `--skip-yay` `--skip-build` `--skip-chsh` `--skip-font` `--help`

Failed steps are listed at the end — install those manually.

## Manual install

```bash
# 1. clone
git clone <repo-url> ~/.config/nvim

# 2. install packages
# Ubuntu/Debian
sudo apt-get install -y zsh git tmux neovim ripgrep fd-find lazygit curl wget unzip build-essential cmake
# Arch
sudo pacman -S --noconfirm zsh git tmux neovim ripgrep fd lazygit curl wget unzip base-devel cmake
# macOS
brew install zsh git tmux neovim ripgrep fd lazygit curl wget cmake

# 3. link dotfiles
for f in ~/.config/nvim/dotfiles/*; do
  ln -sf "$f" ~/".$(basename "$f")"
done

# 4. tmux TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 5. open nvim (lazy.nvim auto-installs plugins)
nvim

# 6. install tmux plugins (inside tmux)
~/.tmux/plugins/tpm/bin/install_plugins
```

## Post-install

- Set API tokens in `~/.zshrc` (look for `<your-token>` placeholders)
- Restart shell or log out & back in (needed for chsh and font changes)
- Set terminal font to **JetBrainsMono Nerd Font** for tmux/nvim icons
- (macOS) Manual font install: `brew install --cask font-jetbrains-mono-nerd-font`
- (Linux) Font installed to `~/.local/share/fonts` — set in your terminal emulator
