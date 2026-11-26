
import '../data/repositori_tugas.dart';
import '../model/tugas.dart';

class PengendaliTugas {
  PengendaliTugas(this._repo);

  final RepositoriTugas _repo;
  String? _galat;
  bool _filterBelumSelesai = false;

  List<Tugas> get daftar => _repo.daftar;

  List<Tugas> get daftarTerlihat {
    if (!_filterBelumSelesai) return daftar;

    return daftar.where((tugas) => !tugas.selesai).toList();
  }

  String? get galat => _galat;

  bool get filterBelumSelesai => _filterBelumSelesai;

  int get jumlahSelesai =>
      daftar.where((tugas) => tugas.selesai).length;

  void ubahFilter(bool aktif) {
    _filterBelumSelesai = aktif;
  }

  bool tambah(String input) {
    _galat = validasiJudul(input);

    if (_galat != null) return false;

    _repo.tambah(input.trim());
    return true;
  }

  void ubahStatus(int id) => _repo.ubahStatus(id);
}
