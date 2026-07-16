# Neovim Cheat Sheet

## Leader = Space

### Dasar
| Tombol | Fungsi |
|--------|--------|
| `Space + w` | Simpan file |
| `Space + q` | Tutup file |
| `Esc` | Hilangin highlight |

### Cari File / Navigasi
| Tombol | Fungsi |
|--------|--------|
| `Space + ff` | Cari file (Telescope) |
| `Space + fg` | Cari teks (live grep) |
| `Space + fw` | Cari teks dari kata di cursor |
| `Space + fb` | Daftar buffer |
| `Space + e` | File explorer |
| `s` / `S` | Flash jump ke lokasi manapun di layar |

### OpenCode (AI Chat / Codebase Tanya)
| Tombol | Fungsi |
|--------|--------|
| `Space + oa` | Tanya OpenCode (@this) |
| `Space + os` | Pilih mode OpenCode |
| `go` | Append selection ke OpenCode |
| `goo` | Append baris ke OpenCode |
| `Shift+Ctrl+u` | Scroll OpenCode up |
| `Shift+Ctrl+d` | Scroll OpenCode down |

### Code Tracing (OSS)
| Tombol | Fungsi |
|--------|--------|
| `gd` | Lompat ke definisi |
| `gr` | Cari semua referensi |
| `gi` | Lompat ke implementasi |
| `K` | Lihat docs (hover) |
| `Space + ci` | Siapa yang manggil fungsi ini? |
| `Space + co` | Fungsi ini manggil apa aja? |
| `Space + cA` | Aerial — liat struktur file (sidebar) |
| `Space + rn` | Rename symbol |
| `Space + ca` | Code action |
| `[d` / `]d` | Prev/next diagnostic |

### Harpoon (file favorit)
| Tombol | Fungsi |
|--------|--------|
| `Space + a` | Tandai file ini |
| `Ctrl + e` | Lihat daftar file |
| `Space + 1` | Loncat file 1 |
| `Space + 2` | Loncat file 2 |
| `Space + 3` | Loncat file 3 |
| `Space + 4` | Loncat file 4 |

### Treesitter Textobjects
| Tombol | Fungsi |
|--------|--------|
| `af` / `if` | Select function (outer/inner) |
| `ac` / `ic` | Select class |
| `aa` / `ia` | Select parameter |
| `ab` / `ib` | Select block |
| `]f` / `[f` | Next/prev function |
| `]c` / `[c` | Next/prev class |

### Diagnostics
| Tombol | Fungsi |
|--------|--------|
| `Space + xx` | Semua error |
| `Space + xX` | Error file ini |
| `Space + cs` | Daftar simbol (Trouble) |
| `Space + cl` | LSP ref/def (Trouble sidebar) |
| `Space + xL` | Location list |
| `Space + xQ` | Quickfix list |

### Edit
| Tombol | Fungsi |
|--------|--------|
| `gcc` | Comment baris |
| `ysiw"` | Bungkus kata dgn `"` |
| `cs"'` | Ganti `"..."` jadi `'...'` |
| `ds"` | Hapus tanda petik |
| `Space + sn` | Tukar parameter (next) |
| `Space + sp` | Tukar parameter (prev) |

### TODO
| Tombol | Fungsi |
|--------|--------|
| `]t` / `[t` | Loncat TODO/FIXME |
| `Space + ft` | Cari semua TODO |

### Undo
| Tombol | Fungsi |
|--------|--------|
| `Space + u` | Visual undo tree |

### Git
| Tombol | Fungsi |
|--------|--------|
| `Space + lg` | LazyGit |

### Tmux
| Cmd | Fungsi |
|-----|--------|
| `tmux new -s paper` | Session baru |
| `tmux attach -t paper` | Masuk session |
| `Ctrl+Space` | Prefix tmux |
| `Alt+h/j/k/l` | Pindah tmux pane |
| `\|` | Split vertikal |
| `-` | Split horizontal |
