import 'package:flutter_test/flutter_test.dart';
import 'package:prak_arsitektur_tugas/main.dart';

void main() {
  testWidgets('beranda membuka kedua implementasi', (tester) async {
    await tester.pumpWidget(const AplikasiTugas());

    await tester.tap(find.text('Buka MVC'));
    await tester.pumpAndSettle();
    expect(find.text('Daftar Tugas · MVC'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Buka MVVM'));
    await tester.pumpAndSettle();
    expect(find.text('Daftar Tugas · MVVM'), findsOneWidget);
  });
}
