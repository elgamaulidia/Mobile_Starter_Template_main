
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prak_arsitektur_tugas/main.dart';

void main() {
  for (final mode in ['MVC', 'MVVM']) {
    testWidgets('$mode memperbarui form dan ringkasan',
        (tester) async {
      await tester.pumpWidget(const AplikasiTugas());

      await tester.tap(find.text('Buka $mode'));
      await tester.pumpAndSettle();

      final input = find.byKey(
        const ValueKey('judul-tugas'),
      );

      final tambah = find.text('Tambah tugas');

      await tester.enterText(input, 'UI');
      await tester.tap(tambah);
      await tester.pumpAndSettle();

      expect(
        find.text('Judul minimal 4 karakter.'),
        findsOneWidget,
      );

      expect(
        find.text('Belum ada tugas.'),
        findsOneWidget,
      );

      await tester.enterText(input, 'Rancang UI Flutter');
      await tester.tap(tambah);
      await tester.pumpAndSettle();

      expect(
        find.text('Rancang UI Flutter'),
        findsOneWidget,
      );

      expect(
        find.text('0 dari 1 selesai'),
        findsOneWidget,
      );

      await tester.tap(find.byType(CheckboxListTile));
      await tester.pumpAndSettle();

      expect(
        find.text('1 dari 1 selesai'),
        findsOneWidget,
      );

      // Menguji checkbox ketika diklik kembali.
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pumpAndSettle();

      expect(
        find.text('0 dari 1 selesai'),
        findsOneWidget,
      );
    });
  }
}
