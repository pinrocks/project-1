#!/bin/bash

# =================================================================
# --- KONFIGURASI WAJIB ---
# GANTI BARIS DI BAWAH INI DENGAN URL REPOSITORY GITHUB KAMU
GITHUB_URL="https://github.com/pinrocks/project-1"
# =================================================================


# --- Konfigurasi Opsional ---
JUMLAH_COMMIT=5
PESAN_DASAR="feat: Menambahkan catatan progress"
NAMA_FILE="progress.md"
BRANCH_UTAMA="main"


# --- SCRIPT UTAMA (TIDAK PERLU DIUBAH) ---
echo "⚙️  Memulai script otomatis..."

# 1. Inisialisasi Git jika folder ini bukan repository
if [ ! -d ".git" ]; then
    echo "   -> Folder bukan repository. Menjalankan 'git init'..."
    git init
fi

# 2. Hubungkan ke remote 'origin' jika belum ada
if ! git remote -v | grep -q "origin"; then
    echo "   -> Menghubungkan ke remote GitHub..."
    git remote add origin "$GITHUB_URL"
fi

# 3. Proses membuat commit dan push
echo "🚀 Memulai siklus $JUMLAH_COMMIT commit..."
for i in $(seq 1 $JUMLAH_COMMIT)
do
    # Membuat konten unik lalu menjalankan add, commit, dan push
    echo "# Update ke-$i pada $(date)" > $NAMA_FILE && \
    git add $NAMA_FILE && \
    git commit -m "$PESAN_DASAR #$i" -q && \
    git push origin $BRANCH_UTAMA && \
    echo "   ✅ Commit #$i berhasil di-push." || \
    { echo "   ❌ Gagal pada commit #$i. Script berhenti."; exit 1; }
done

echo "🎉 Semua proses selesai dengan sukses!"