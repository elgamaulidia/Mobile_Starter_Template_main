import 'dart:async';

import 'package:flutter/material.dart';

import '../../modul_06/models/sesi_pengguna.dart';
import '../../modul_06/services/auth_api.dart';
import '../../modul_06/services/sesi_memori.dart';
import 'controllers/sesi_controller.dart';
import 'repositories/aman_sesi_repository.dart';
import 'repositories/memori_sesi_repository.dart';
import 'repositories/prefs_sesi_repository.dart';
import 'repositories/sesi_repository.dart';
import 'screens/beranda_pengayaan_screen.dart';
import 'screens/login_pengayaan_screen.dart';
import 'storage/penyimpanan_aman_platform.dart';
import 'widgets/gerbang_sesi.dart';
import 'widgets/papan_diagnostik_penyimpanan.dart';

class Modul06PengayaanApp extends StatefulWidget {
  const Modul06PengayaanApp({super.key});

  @override
  State<Modul06PengayaanApp> createState() =>
      _Modul06PengayaanAppState();
}

class _Modul06PengayaanAppState
    extends State<Modul06PengayaanApp> {
  final SesiMemori _memori = SesiMemori();
  final AuthApi _api = const AuthApi();

  String _pilihan = 'Memori';
  late SesiController _controller;

  SesiRepository _buatRepository(String pilihan) {
    switch (pilihan) {
      case 'Prefs':
        return PrefsSesiRepository();

      case 'Penyimpanan Aman':
        return AmanSesiRepository(
          penyimpanan: PenyimpananAmanPlatform(),
        );

      default:
        return MemoriSesiRepository(memori: _memori);
    }
  }

  SesiController _buatController(String pilihan) {
    return SesiController(
      repository: _buatRepository(pilihan),
      api: _api,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = _buatController(_pilihan);
    unawaited(_controller.pulihkan());
  }

  void _gantiPenyimpanan(String? pilihan) {
    if (pilihan == null || pilihan == _pilihan) return;

    final SesiController controllerLama = _controller;
    final SesiController controllerBaru =
        _buatController(pilihan);

    setState(() {
      _pilihan = pilihan;
      _controller = controllerBaru;
    });

    controllerLama.dispose();
    unawaited(controllerBaru.pulihkan());
  }

  void _bukaDiagnostik(BuildContext buttonContext) {
    showDialog<void>(
      context: buttonContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.security_outlined),
              SizedBox(width: 8),
              Expanded(
                child: Text('Diagnostik Penyimpanan'),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 420,
              child: PapanDiagnostikPenyimpanan(
                repository: _controller.repository,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengayaan Modul 06',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pengayaan Modul 06'),
          actions: [
            Builder(
              builder: (BuildContext buttonContext) {
                return IconButton(
                  tooltip: 'Diagnostik Penyimpanan',
                  icon: const Icon(Icons.security_outlined),
                  onPressed: () {
                    _bukaDiagnostik(buttonContext);
                  },
                );
              },
            ),
            PopupMenuButton<String>(
              tooltip: 'Pilih penyimpanan sesi',
              initialValue: _pilihan,
              onSelected: _gantiPenyimpanan,
              itemBuilder: (BuildContext context) => const [
                PopupMenuItem<String>(
                  value: 'Memori',
                  child: Text('Memori'),
                ),
                PopupMenuItem<String>(
                  value: 'Prefs',
                  child: Text('SharedPreferences'),
                ),
                PopupMenuItem<String>(
                  value: 'Penyimpanan Aman',
                  child: Text('Penyimpanan Aman'),
                ),
              ],
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.storage),
                    const SizedBox(width: 4),
                    Text(_pilihan),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: GerbangSesi(
            controller: _controller,
            form: (BuildContext context) =>
                LoginPengayaanScreen(
              controller: _controller,
            ),
            beranda: (
              BuildContext context,
              SesiPengguna sesi,
            ) =>
                BerandaPengayaanScreen(
              controller: _controller,
              sesi: sesi,
            ),
          ),
        ),
      ),
    );
  }
}