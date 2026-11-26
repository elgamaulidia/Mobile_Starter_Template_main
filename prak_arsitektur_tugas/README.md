# Starter Praktikum Arsitektur Tugas

Jalankan dari folder yang berisi pubspec.yaml dengan Flutter 3.29.2.

    flutter pub get
    flutter test
    flutter run -d chrome

Starter memuat model, repository dalam memori, form, menu, dan smoke test. Kerjakan versi MVC, versi MVVM, dan test tambahan dengan mengikuti PDF praktikum. Layar awal kedua versi berisi petunjuk untuk mulai mengimplementasikan.




# Laporan Praktikum MVC dan MVVM

Nama: Elga Maulidia Akbari
NIM: 362558302130
Program Studi: TRPL
Mata Kuliah: Pemrograman Perangkat Bergerak

Praktikum ini membuat aplikasi Daftar Tugas menggunakan dua arsitektur, yaitu MVC dan MVVM. Aplikasi memiliki fitur tambah tugas, centang tugas selesai, melihat jumlah tugas selesai, dan filter tugas yang belum selesai.

# Persiapan Aplikasi
Sebelum menjalankan aplikasi, saya memasang package, menjalankan pengujian, dan membuka aplikasi melalui Chrome.
![Persiapan Aplikasi](bukti/01-persiapan-dan-menjalankan-aplikasi.png)

# Implementasi MVC
Pada MVC, proses pengelolaan tugas dilakukan oleh `PengendaliTugas`, sedangkan tampilan diatur melalui `LayarMvc`. Perubahan tampilan menggunakan `setState()`.

Filter tidak aktif
![MVC Filter Mati](bukti/02-mvc-filter-mati.png)

Filter aktif
![MVC Filter Aktif](bukti/03-mvc-filter-aktif.png)

# Implementasi MVVM
Pada MVVM, pengelolaan data dilakukan oleh `TugasViewModel`, sedangkan tampilan menggunakan `LayarMvvm`. Perubahan tampilan menggunakan `notifyListeners()` dan `ListenableBuilder`.

Filter tidak aktif
![MVVM Filter Mati](bukti/04-mvvm-filter-mati.png)

Filter aktif
![MVVM Filter Aktif](bukti/05-mvvm-filter-aktif.png)

# Perbandingan MVC dan MVVM
Menurut hasil praktikum, MVC dan MVVM memiliki cara kerja yang berbeda. Pada MVC, pengelolaan tugas dilakukan melalui Controller dan tampilan diperbarui menggunakan `setState()`. Sedangkan pada MVVM, pengelolaan tugas dilakukan melalui ViewModel dan tampilan diperbarui menggunakan `notifyListeners()`. Keduanya dapat menjalankan fitur aplikasi dengan baik.

# Percobaan setState()
Saya mencoba menghilangkan sementara `setState()` pada fungsi `_ubahStatus()`. Hasilnya, perubahan status tugas tidak langsung terlihat pada tampilan. Setelah `setState()` dikembalikan, tampilan dapat diperbarui kembali.

Kode awal
![Kode MVC Awal](bukti/07-mvc-setstate-asli.png)

Kode setelah setState dihilangkan
![Kode MVC Tanpa setState](bukti/08-mvc-setstate-dihilangkan.png)

# Hasil Pengujian
Pengujian dilakukan menggunakan `flutter test` dan `flutter analyze`.
Hasilnya, 7 pengujian berhasil dijalankan dan tidak ditemukan masalah pada kode.

Flutter Analyze
![Hasil Analyze](bukti/06-hasil-flutter-analyze.png)

Flutter Test
![Hasil Test](bukti/09-hasil-flutter-test-mvc.png)
