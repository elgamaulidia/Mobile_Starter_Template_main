
import '../../../modul_06/models/sesi_pengguna.dart';
import '../../../modul_06/services/sesi_memori.dart';
import 'sesi_repository.dart';

class MemoriSesiRepository implements SesiRepository {
  final SesiMemori memori;

  MemoriSesiRepository({required this.memori});

  @override
  String get nama => 'Memori';

  @override
  String get keterangan =>
      'Sesi disimpan sementara di memori aplikasi.';

  @override
  bool get bertahanSetelahRestart => false;

  @override
  Future<SesiPengguna?> baca() async {
    return memori.baca();
  }

  @override
  Future<void> simpan(SesiPengguna sesi) async {
    await memori.simpan(sesi);
  }

  @override
  Future<void> hapus() async {
    await memori.hapus();
  }

  @override
  Future<bool> adaSesi() async {
    return memori.adaSesi;
  }

  @override
  Future<String?> intipMentah() async {
    return null;
  }
}
