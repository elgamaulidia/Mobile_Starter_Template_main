
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../modul_06/models/sesi_pengguna.dart';
import 'sesi_repository.dart';

class PrefsSesiRepository implements SesiRepository {
  static const String kunciSesi = 'sesi_pengguna';

  final Future<SharedPreferences> _prefs;

  PrefsSesiRepository({Future<SharedPreferences>? prefs})
      : _prefs = prefs ?? SharedPreferences.getInstance();

  @override
  String get nama => 'Prefs';

  @override
  String get keterangan =>
      'Sesi disimpan di preferensi biasa dan token dapat dibaca melalui API.';

  @override
  bool get bertahanSetelahRestart => true;

  @override
  Future<SesiPengguna?> baca() async {
    final SharedPreferences prefs = await _prefs;
    final String? data = prefs.getString(kunciSesi);

    if (data == null || data.isEmpty) {
      return null;
    }

    final dynamic json = jsonDecode(data);

    if (json is! Map<String, dynamic>) {
      return null;
    }

    return SesiPengguna.fromJson(json);
  }

  @override
  Future<void> simpan(SesiPengguna sesi) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString(
      kunciSesi,
      jsonEncode(sesi.toJson()),
    );
  }

  @override
  Future<void> hapus() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(kunciSesi);
  }

  @override
  Future<bool> adaSesi() async {
    final SharedPreferences prefs = await _prefs;
    final String? data = prefs.getString(kunciSesi);

    return data != null && data.isNotEmpty;
  }

  @override
  Future<String?> intipMentah() async {
    final SharedPreferences prefs = await _prefs;

    // Demonstrasi ini memperlihatkan bahwa adapter preferensi dapat
    // mengembalikan nilai token melalui API biasa.
    return prefs.getString(kunciSesi);
  }
}
