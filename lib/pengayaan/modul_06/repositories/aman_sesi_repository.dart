import 'dart:convert';

import '../../../modul_06/models/sesi_pengguna.dart';
import '../storage/penyimpanan_aman_platform.dart';
import 'sesi_repository.dart';

class AmanSesiRepository implements SesiRepository {
  final PenyimpananAmanPlatform penyimpanan;

  static const String kunciSesi = 'sesi_pengguna';

  AmanSesiRepository({
    required this.penyimpanan,
  });

  @override
  String get nama => 'FlutterSecureStorage';

  @override
  String get keterangan =>
      'Menggunakan API secure storage; perlindungan aktual mengikuti platform dan konfigurasi.';

  @override
  bool get bertahanSetelahRestart => true;

  @override
  Future<SesiPengguna?> baca() async {
    final String? data = await penyimpanan.baca(kunciSesi);

    if (data == null || data.isEmpty) {
      return null;
    }

    try {
      final dynamic hasilJson = jsonDecode(data);

      if (hasilJson is! Map<String, dynamic>) {
        return null;
      }

      return SesiPengguna.fromJson(hasilJson);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> simpan(SesiPengguna sesi) async {
    await penyimpanan.tulis(
      kunciSesi,
      jsonEncode(sesi.toJson()),
    );
  }

  @override
  Future<void> hapus() async {
    await penyimpanan.hapus(kunciSesi);
  }

  @override
  Future<bool> adaSesi() async {
    final String? data = await penyimpanan.baca(kunciSesi);
    return data != null && data.isNotEmpty;
  }

  @override
  Future<String?> intipMentah() async {
    return penyimpanan.bacaMentah(kunciSesi);
  }
}
