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

### Database (dadbod + masume)
| Tombol / Cmd | Fungsi |
|--------|--------|
| `Space + du` | DB drawer (DBUI) — browse staging/prod/local |
| `Space + db` (visual) | Jalankan query yang di-select ke **staging** |
| `Space + dB` | Jalankan seluruh buffer ke **staging** |
| `Space + df` | Cari buffer DB |
| `Space + da` | Tambah koneksi manual |
| `Space + dq` | Info query terakhir |
| `:DB g:perpus_prod <query>` | Query ke **prod** (ketik manual, hati-hati) |
| `masume` (di terminal) | TUI modern: object tree, ER diagram, grid editor |
| `perpus-db start/stop/status` | Nyalakan/matikan SSH tunnel buat dadbod |

#### Dadbod — query cepat di buffer (staging)
1. `perpus-db start` dulu di terminal (sekali aja, tunnel persistent).
2. Di nvim: `Space + du` → drawer kebuka, `o`/`Enter` di tabel buat liat isi.
3. Tulis `.sql` file, select query → `Space + db` → hasil muncul di split.
4. Completion nama tabel/kolom otomatis aktif di file `sql`.
5. Query drawer: `o` buka, `S` buka di vertical split, `R` redraw, `A` tambah koneksi.

> Staging aman buat eksperimen. **Prod (`g:perpus_prod`) cuma via `:DB` manual** —
> nggak ada keymap sekali-pencet biar nggak kepencet. Double-check sebelum Enter.

#### Masume — explore schema + query aman (staging & prod)
1. `masume` → picker muncul: `perpus-staging` / `perpus-prod` → Enter.
2. Tunnel SSH naik otomatis (15432/15433), mati sendiri pas disconnect.
3. Tree: panah navigasi, `Enter` buka tabel, `i` liat kolom, `m` menu objek.
4. Query: `Alt+N` tab baru, ketik SQL, `Ctrl+R` jalanin statement, `Alt+R` semua.
5. Hasil: `s` sort, `f` filter, `g` ikutin foreign key, `y` copy menu.
6. `?` bantuan, `Ctrl+K` command palette, `Ctrl+C` keluar.
7. Prod kebuka **read-only + warna merah** — write ditolak client, aman.
8. `masume dump perpus-prod backup.sql` → dump schema tanpa buka TUI.

### Tmux
| Cmd | Fungsi |
|-----|--------|
| `tmux new -s paper` | Session baru |
| `tmux attach -t paper` | Masuk session |
| `Ctrl+Space` | Prefix tmux |
| `Alt+h/j/k/l` | Pindah tmux pane |
| `\|` | Split vertikal |
| `-` | Split horizontal |
