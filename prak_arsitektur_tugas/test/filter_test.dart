
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prak_arsitektur_tugas/main.dart';

void main() {
  for (final mode in ['MVC', 'MVVM']) {
    testWidgets('$mode menjalankan filter belum selesai',
        (tester) async {
      await tester.pumpWidget(const AplikasiTugas());

      await tester.tap(find.text('Buka $mode'));
      await tester.pumpAndSettle();

      final input = find.byKey(
        const ValueKey('judul-tugas'),
      );

      final tambah = find.text('Tambah tugas');

      // Menambahkan dua tugas.
      await tester.enterText(input, 'Rancang UI Flutter');
      await tester.tap(tambah);
      await tester.pumpAndSettle();

      await tester.enterText(input, 'Catat hasil pengujian');
      await tester.tap(tambah);
      await tester.pumpAndSettle();

      expect(find.text('Rancang UI Flutter'), findsOneWidget);
      expect(find.text('Catat hasil pengujian'), findsOneWidget);

      // Menyelesaikan tugas pertama.
      await tester.tap(find.byType(CheckboxListTile).first);
      await tester.pumpAndSettle();

      expect(find.text('1 dari 2 selesai'), findsOneWidget);

      // Mengaktifkan filter.
      await tester.tap(
        find.byKey(const ValueKey('filter-belum-selesai')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rancang UI Flutter'), findsNothing);
      expect(find.text('Catat hasil pengujian'), findsOneWidget);
      expect(find.text('1 dari 2 selesai'), findsOneWidget);

      // Mematikan filter.
      await tester.tap(
        find.byKey(const ValueKey('filter-belum-selesai')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rancang UI Flutter'), findsOneWidget);
      expect(find.text('Catat hasil pengujian'), findsOneWidget);

      // Memastikan tugas pertama masih selesai.
      final checkboxPertama = tester.widget<CheckboxListTile>(
        find.byType(CheckboxListTile).first,
      );
      expect(checkboxPertama.value, isTrue);

      // Mengaktifkan filter kembali.
      await tester.tap(
        find.byKey(const ValueKey('filter-belum-selesai')),
      );
      await tester.pumpAndSettle();

      // Menyelesaikan tugas kedua.
      await tester.tap(find.byType(CheckboxListTile).first);
      await tester.pumpAndSettle();

      expect(
        find.text('Tidak ada tugas yang belum selesai.'),
        findsOneWidget,
      );
      expect(find.text('2 dari 2 selesai'), findsOneWidget);
    });
  }
}
