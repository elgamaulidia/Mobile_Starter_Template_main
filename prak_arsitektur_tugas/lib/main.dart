import 'package:flutter/material.dart';

import 'mvc/layar_mvc.dart';
import 'mvvm/layar_mvvm.dart';

void main() => runApp(const AplikasiTugas());

class AplikasiTugas extends StatelessWidget {
  const AplikasiTugas({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Praktikum Arsitektur Tugas',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xff17656b),
      useMaterial3: true,
    ),
    home: const _Beranda(),
    routes: {
      '/mvc': (_) => const LayarMvc(),
      '/mvvm': (_) => const LayarMvvm(),
    },
  );
}

class _Beranda extends StatelessWidget {
  const _Beranda();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Daftar Tugas')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Pilih implementasi yang ingin Anda jalankan.'),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => Navigator.pushNamed(context, '/mvc'),
          child: const Text('Buka MVC'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, '/mvvm'),
          child: const Text('Buka MVVM'),
        ),
      ],
    ),
  );
}
