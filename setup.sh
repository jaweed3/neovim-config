#!/usr/bin/env bash
set -uo pipefail

DOTDIR="$(cd "$(dirname "$0")" && pwd)"
FAILURES=()
SKIP=()
YES=0
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --skip-deps       Skip system package installation
  --skip-link       Skip symlinking dotfiles
  --skip-tpm        Skip tmux TPM installation
  --skip-rust       Skip Rust installation
  --skip-bun        Skip Bun installation
  --skip-opencode   Skip opencode installation
  --skip-grok       Skip Grok CLI installation
  --skip-yay        Skip yay installation (Arch only)
  --skip-build      Skip build tools (gcc, make, cmake)
  --skip-chsh       Skip changing default shell to zsh
  --skip-font       Skip Nerd Font installation
  --yes             Auto-confirm all prompts (default when no --skip flags)
  --help            Show this help
EOF
  exit 0
}

os() { case "$(uname -s)" in Linux) echo linux;; Darwin) echo macos;; esac }

pkg_mgr() {
  command -v apt-get &>/dev/null && echo "apt" && return
  command -v pacman &>/dev/null && echo "pacman" && return
  command -v brew &>/dev/null && echo "brew" && return
  echo "unknown"
}

should_skip() {
  local s; for s in "${SKIP[@]}"; do [ "$s" = "$1" ] && return 0; done; return 1
}

run() {
  local cmd_str="$*"
  if ! "$@"; then
    FAILURES+=("$cmd_str")
    warn "FAILED: $cmd_str"
  fi
}

try_sudo() {
  if [ "$(os)" != "macos" ] && ! command -v sudo &>/dev/null; then
    warn "sudo not found — skipping: $*"
    return 1
  fi
  "$@"
}

for arg in "$@"; do
  case "$arg" in
    --skip-*) SKIP+=("${arg#--skip-}") ;;
    --yes) YES=1 ;;
    --help) usage ;;
    *) warn "Unknown option: $arg"; usage ;;
  esac
done

install_deps() {
  should_skip "deps" && return
  info "=== system packages ==="
  local build=""
  if ! should_skip "build"; then
    case "$(os)" in
      linux)
        case "$(pkg_mgr)" in
          apt) build="build-essential cmake" ;;
          pacman) build="base-devel cmake" ;;
        esac
        ;;
      macos) build="cmake" ;;
    esac
  fi
  case "$(os)" in
    linux)
      case "$(pkg_mgr)" in
        apt)
          try_sudo apt-get update
          run try_sudo apt-get install -y zsh git tmux neovim ripgrep fd-find lazygit curl wget unzip $build
          ;;
        pacman)
          run try_sudo pacman -Syu --noconfirm zsh git tmux neovim ripgrep fd lazygit curl wget unzip $build
          ;;
        *) warn "unknown pkg manager, install deps manually" ;;
      esac
      ;;
    macos)
      if ! command -v brew &>/dev/null; then
        run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      if command -v brew &>/dev/null; then
        run brew install zsh git tmux neovim ripgrep fd lazygit curl wget cmake
      fi
      ;;
  esac
}

install_yay() {
  should_skip "yay" && return
  [ "$(os)" != "linux" ] && return
  [ "$(pkg_mgr)" != "pacman" ] && return
  command -v yay &>/dev/null && return
  info "=== yay (AUR helper) ==="
  run git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && run makepkg -si --noconfirm)
  run rm -rf /tmp/yay
}

install_rust() {
  should_skip "rust" && return
  command -v rustc &>/dev/null && return
  info "=== rust ==="
  run curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup.sh
  run sh /tmp/rustup.sh -y
  . "$HOME/.cargo/env"
}

install_bun() {
  should_skip "bun" && return
  command -v bun &>/dev/null && return
  info "=== bun ==="
  run curl -fsSL https://bun.sh/install -o /tmp/bun-install.sh
  run bash /tmp/bun-install.sh
}

install_opencode() {
  should_skip "opencode" && return
  [ -f "$HOME/.opencode/bin/opencode" ] && return
  info "=== opencode ==="
  warn "opencode is a standalone binary — install from https://opencode.ai or:"
  warn "  curl -fsSL https://opencode.ai/install.sh | bash"
  warn "  (skipping — no automated install available)"
}

install_grok() {
  should_skip "grok" && return
  command -v grok &>/dev/null && return
  info "=== grok ==="
  warn "Grok CLI — install from https://grok.com/cli or:"
  warn "  curl -fsSL https://grok.com/cli/install.sh | bash"
  warn "  (skipping — no automated install available)"
}

link() {
  should_skip "link" && return
  info "=== dotfiles ==="
  if [ "$DOTDIR" != "$HOME/.config/nvim" ]; then
    mkdir -p "$HOME/.config"
    if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
      mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
      warn "backed up ~/.config/nvim -> ~/.config/nvim.bak"
    fi
    ln -sfn "$DOTDIR" "$HOME/.config/nvim"
    info "linked ~/.config/nvim -> $DOTDIR"
  fi
  for f in "$DOTDIR"/dotfiles/*; do
    [ -f "$f" ] || continue
    name=".$(basename "$f")"
    target="$HOME/$name"
    if [ -f "$target" ] && [ ! -L "$target" ]; then
      mv "$target" "$target.bak"
      warn "backed up $target -> $target.bak"
    fi
    ln -sf "$f" "$target"
    info "linked $target"
  done
}

set_zsh_shell() {
  should_skip "chsh" && return
  local zsh_path
  zsh_path="$(command -v zsh)" || return
  if [ "$SHELL" = "$zsh_path" ]; then
    info "zsh is already default shell"
    return
  fi
  info "=== default shell: zsh ==="
  if [ "$(os)" = "linux" ]; then
    run try_sudo chsh -s "$zsh_path" "$USER"
  else
    run chsh -s "$zsh_path"
  fi
}

install_font() {
  should_skip "font" && return
  info "=== JetBrainsMono Nerd Font ==="
  case "$(os)" in
    macos)
      run brew install --cask font-jetbrains-mono-nerd-font
      ;;
    linux)
      local dest="$HOME/.local/share/fonts"
      local url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
      mkdir -p "$dest"
      run curl -fsSL "$url" -o /tmp/JetBrainsMono.zip
      run unzip -qo /tmp/JetBrainsMono.zip -d "$dest"
      run rm /tmp/JetBrainsMono.zip
      run fc-cache -f "$dest"
      info "font installed — set in your terminal emulator settings"
      ;;
  esac
}

install_tpm() {
  should_skip "tpm" && return
  [ -d "$HOME/.tmux/plugins/tpm" ] && return
  info "=== tmux TPM ==="
  run git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
}

info "dotfiles: $DOTDIR"
install_deps
install_yay
install_rust
install_bun
install_opencode
install_grok
link
set_zsh_shell
install_font
install_tpm

echo -e "${GREEN}Done!${NC}"
if [ ${#FAILURES[@]} -gt 0 ]; then
  warn "N/A — install manually:"
  printf '  \033[1;33m- %s\033[0m\n' "${FAILURES[@]}"
fi
echo ""
info "Next steps:"
echo "  1. Log out & back in (or restart) for shell/font changes"
echo "  2. nvim             (lazy.nvim auto-installs plugins)"
echo "  3. In tmux: ~/.tmux/plugins/tpm/bin/install_plugins"
echo "  4. Set API tokens in ~/.zshrc (look for <your-token>)"
