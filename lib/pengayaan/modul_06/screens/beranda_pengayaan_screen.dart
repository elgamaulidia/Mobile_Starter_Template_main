import 'package:flutter/material.dart';

import '../../../modul_06/models/sesi_pengguna.dart';
import '../../../modul_06/widgets/kartu_sesi.dart';
import '../controllers/sesi_controller.dart';

class BerandaPengayaanScreen extends StatefulWidget {
  final SesiController controller;
  final SesiPengguna sesi;

  const BerandaPengayaanScreen({
    super.key,
    required this.controller,
    required this.sesi,
  });

  @override
  State<BerandaPengayaanScreen> createState() =>
      _BerandaPengayaanScreenState();
}

class _BerandaPengayaanScreenState
    extends State<BerandaPengayaanScreen> {
  bool _tampilkanToken = false;

  @override
  Widget build(BuildContext context) {
    final SesiPengguna sesi = widget.sesi;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Beranda Pengayaan Fase B',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Selamat datang, ${sesi.nama}!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        KartuSesi(
          sesi: sesi,
          sekarang: DateTime.now(),
          tampilkanToken: _tampilkanToken,
          onKeluar: () async {
            try {
              await widget.controller.keluar();

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Berhasil keluar dari sesi.'),
                ),
              );
            } catch (_) {
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Sesi gagal dihapus. Silakan coba lagi.',
                  ),
                ),
              );
            }
          },
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              _tampilkanToken = !_tampilkanToken;
            });
          },
          icon: Icon(
            _tampilkanToken
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          label: Text(
            _tampilkanToken ? 'Sembunyikan Token' : 'Intip Token',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Penyimpanan sesi: ${widget.controller.repository.nama}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}