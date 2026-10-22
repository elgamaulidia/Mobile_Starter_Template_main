import 'package:flutter/material.dart';

import '../repositories/sesi_repository.dart';

class PapanDiagnostikPenyimpanan extends StatefulWidget {
  final SesiRepository repository;

  const PapanDiagnostikPenyimpanan({
    super.key,
    required this.repository,
  });

  @override
  State<PapanDiagnostikPenyimpanan> createState() =>
      _PapanDiagnostikPenyimpananState();
}

class _PapanDiagnostikPenyimpananState
    extends State<PapanDiagnostikPenyimpanan> {
  bool _sedangMemeriksa = false;
  bool _sudahMemeriksa = false;
  String _hasil = '';

  Future<void> _periksa() async {
    setState(() {
      _sedangMemeriksa = true;
      _sudahMemeriksa = false;
      _hasil = '';
    });

    try {
      final String? data =
          await widget.repository.intipMentah();

      if (!mounted) return;

      setState(() {
        _hasil = data == null
            ? 'Nilai mentah tidak tersedia melalui API Secure Storage.'
            : 'Data tersedia melalui API diagnostik.';
        _sudahMemeriksa = true;
        _sedangMemeriksa = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _hasil = 'Pemeriksaan gagal. Periksa konfigurasi penyimpanan.';
        _sudahMemeriksa = true;
        _sedangMemeriksa = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diagnostik Penyimpanan',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text('Metode: ${widget.repository.nama}'),
            const SizedBox(height: 8),
            Text(widget.repository.keterangan),
            const SizedBox(height: 8),
            Text(
              'Bertahan setelah restart: '
              '${widget.repository.bertahanSetelahRestart ? "Ya" : "Tidak"}',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _sedangMemeriksa ? null : _periksa,
                child: Text(
                  _sedangMemeriksa
                      ? 'Memeriksa...'
                      : 'Intip isi penyimpanan',
                ),
              ),
            ),
            if (_sudahMemeriksa) ...[
              const SizedBox(height: 16),
              const Text(
                'Hasil pemeriksaan:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_hasil),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              'Catatan: pemeriksaan ini menunjukkan kemampuan '
              'API aplikasi, bukan pemeriksaan forensik perangkat.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}