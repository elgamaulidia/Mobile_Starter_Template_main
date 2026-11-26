
import 'package:flutter_test/flutter_test.dart';
import 'package:prak_arsitektur_tugas/data/repositori_tugas.dart';
import 'package:prak_arsitektur_tugas/mvc/pengendali_tugas.dart';
import 'package:prak_arsitektur_tugas/mvvm/tugas_view_model.dart';

void main() {
  test('MVC menyimpan judul valid dan mengubah status', () {
    final controller = PengendaliTugas(RepositoriTugas());

    expect(controller.tambah('UI'), isFalse);
    expect(controller.daftar, isEmpty);

    expect(
      controller.tambah(' Rancang UI Flutter '),
      isTrue,
    );

    expect(
      controller.daftar.single.judul,
      'Rancang UI Flutter',
    );

    controller.ubahStatus(controller.daftar.single.id);

    expect(controller.jumlahSelesai, 1);
  });

  test('MVVM memberi notifikasi setelah state berubah', () {
    final vm = TugasViewModel(RepositoriTugas());
    addTearDown(vm.dispose);

    final jumlahSaatNotifikasi = <int>[];

    vm.addListener(
      () => jumlahSaatNotifikasi.add(vm.jumlahSelesai),
    );

    expect(vm.tambah('UI'), isFalse);
    expect(vm.galat, 'Judul minimal 4 karakter.');

    expect(vm.tambah('Rancang UI Flutter'), isTrue);
    expect(vm.galat, isNull);

    vm.ubahStatus(vm.daftar.single.id);

    expect(vm.daftar.single.selesai, isTrue);
    expect(jumlahSaatNotifikasi, [0, 0, 1]);
  });
}
