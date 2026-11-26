class Tugas {
  const Tugas({required this.id, required this.judul, this.selesai = false});

  final int id;
  final String judul;
  final bool selesai;

  Tugas balikStatus() => Tugas(id: id, judul: judul, selesai: !selesai);
}

String? validasiJudul(String input) {
  if (input.trim().length < 4) return 'Judul minimal 4 karakter.';
  return null;
}
