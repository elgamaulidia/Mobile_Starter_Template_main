class Course {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final double progress;
  final String room;
  final String type;
  final List<String> syllabus;

  const Course({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    required this.progress,
    this.room = 'Lab Komputer 3',
    this.type = 'Teori',
    this.syllabus = const [],
  });

  static List<Course> getSampleCourses() {
    return const [
      Course(
        code: 'TRPL501',
        name: 'Pemrograman Web Lanjut',
        lecturer: 'Devit Suwardiyanto, S.Si., MT',
        sks: 4,
        progress: 0.30,
        room: 'LAB.MULTIMEDIA',
        type: 'Praktikum',
        syllabus: [
          'Konsep Pemrograman Web Lanjut',
          'Framework Pemrograman Web',
          'Pengelolaan Database',
          'Pemrograman Backend',
          'Pemrograman Frontend',
          'Integrasi Backend dan Frontend',
          'Autentikasi dan Otorisasi',
          'Pengembangan Aplikasi Web',
        ],
      ),
      Course(
        code: 'TRPL502',
        name: 'Interoperabilitas',
        lecturer: 'Ahmad Ripaldi, S.Kom.',
        sks: 4,
        progress: 0.25,
        room: 'LAB.MULTIMEDIA',
        type: 'Praktikum',
        syllabus: [
          'Konsep Interoperabilitas',
          'Integrasi Sistem',
          'Web Service',
          'REST API',
          'Format Data JSON',
          'Komunikasi Antar Sistem',
          'Integrasi Database',
          'Implementasi Interoperabilitas',
        ],
      ),
      Course(
        code: 'TRPL503',
        name: 'Metode dan Model Pengembangan Perangkat',
        lecturer: 'Ruth Ema Febrita, S.Pd., M.Kom',
        sks: 3,
        progress: 0.40,
        room: 'G6.04',
        type: 'Teori',
        syllabus: [
          'Konsep Pengembangan Perangkat Lunak',
          'Metode Waterfall',
          'Metode Agile',
          'Model Spiral',
          'Prototype Model',
          'Scrum',
          'Pemilihan Model Pengembangan',
        ],
      ),
      Course(
        code: 'TRPL504',
        name: 'Pancasila',
        lecturer: 'Ninik Sri Rahayu, SH, MH',
        sks: 2,
        progress: 0.50,
        room: 'G6.02',
        type: 'Teori',
        syllabus: [
          'Pancasila sebagai Dasar Negara',
          'Sejarah Perumusan Pancasila',
          'Nilai-Nilai Pancasila',
          'Pancasila dalam Kehidupan Bermasyarakat',
          'Pancasila dalam Kehidupan Berbangsa',
          'Pancasila sebagai Ideologi Negara',
        ],
      ),
      Course(
        code: 'TRPL505',
        name: 'Statistika',
        lecturer: 'Siska Aprilia Hardiyanti, S.Pd., M.Si',
        sks: 3,
        progress: 0.35,
        room: 'G6.02',
        type: 'Teori',
        syllabus: [
          'Konsep Dasar Statistika',
          'Penyajian Data',
          'Ukuran Pemusatan Data',
          'Ukuran Penyebaran Data',
          'Kuartil, Desil, dan Persentil',
          'Statistika Deskriptif',
          'Analisis Data',
        ],
      ),
      Course(
        code: 'TRPL506',
        name: 'Basis Data Lanjut',
        lecturer: 'Eka Mistiko Rini, S.Kom, M.Kom.',
        sks: 4,
        progress: 0.45,
        room: 'LAB.PROGRAM 2',
        type: 'Praktikum',
        syllabus: [
          'Konsep Basis Data Lanjut',
          'Database Relasional',
          'Query Lanjutan',
          'Join dan Subquery',
          'View',
          'Stored Procedure',
          'Trigger',
          'Pengelolaan Database',
        ],
      ),
      Course(
        code: 'TRPL507',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Sepyan Purnama Kristanto, S.Kom., M.Kom',
        sks: 4,
        progress: 0.25,
        room: 'LAB.TUK',
        type: 'Praktikum',
        syllabus: [
          'Konsep Dasar Flutter dan Dart',
          'Widget dan Widget Tree',
          'Layout Responsif',
          'StatefulWidget dan setState',
          'Navigasi Antar Halaman',
          'ListView dan GridView',
          'Form dan Validasi Input',
          'Pengembangan Aplikasi Mobile',
        ],
      ),
      Course(
        code: 'TRPL508',
        name: 'Rekayasa Kebutuhan Perangkat Lunak',
        lecturer: 'Eka Novita Sari, S.Kom., M.Kom',
        sks: 3,
        progress: 0.30,
        room: 'G7.10',
        type: 'Teori',
        syllabus: [
          'Konsep Rekayasa Kebutuhan',
          'Identifikasi Kebutuhan',
          'Analisis Kebutuhan',
          'Elicitation Kebutuhan',
          'Spesifikasi Kebutuhan',
          'Validasi Kebutuhan',
          'Dokumentasi Kebutuhan',
          'Manajemen Kebutuhan',
        ],
      ),
    ];
  }
}