import '../model/tugas.dart';

class RepositoriTugas {
  final List<Tugas> _daftar = [];
  int _idBerikutnya = 1;

  List<Tugas> get daftar => List.unmodifiable(_daftar);

  void tambah(String judul) {
    _daftar.add(Tugas(id: _idBerikutnya++, judul: judul));
  }

  void ubahStatus(int id) {
    final indeks = _daftar.indexWhere((tugas) => tugas.id == id);
    if (indeks != -1) {
      _daftar[indeks] = _daftar[indeks].balikStatus();
    }
  }
}
