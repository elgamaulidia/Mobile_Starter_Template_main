import 'package:flutter/material.dart';

import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

class AcademicDashboardScreen extends StatefulWidget {
  const AcademicDashboardScreen({
    super.key,
  });

  @override
  State<AcademicDashboardScreen> createState() =>
      _AcademicDashboardScreenState();
}

class _AcademicDashboardScreenState
    extends State<AcademicDashboardScreen> {
  final List<Course> _courses =
      Course.getSampleCourses();

  bool _isDarkMode = false;

  String _selectedFilter = 'Semua';

  // ==============================================================
  // FILTER
  // ==============================================================

  List<Course> get _filteredCourses {
    if (_selectedFilter == 'Semua') {
      return _courses;
    }

    return _courses
        .where(
          (course) =>
              course.type == _selectedFilter,
        )
        .toList();
  }

  // ==============================================================
  // DARK MODE
  // ==============================================================

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // ==============================================================
  // BUILD
  // ==============================================================

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          brightness: _isDarkMode
              ? Brightness.dark
              : Brightness.light,
        ),
        scaffoldBackgroundColor:
            _isDarkMode
                ? const Color(0xFF101820)
                : const Color(0xFFF5F7FB),
      ),
      child: Scaffold(
        // ==========================================================
        // APP BAR
        // ==========================================================

        appBar: AppBar(
          toolbarHeight: 76,
          backgroundColor:
              const Color(0xFF0785C2),
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 28,
            ),
            onPressed: () {
              Navigator.maybePop(
                context,
              );
            },
          ),
          titleSpacing: 4,
          title: const Text(
            'Dashboard Akademik TRPL',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
              ),
              onPressed:
                  _toggleDarkMode,
            ),
            const SizedBox(width: 8),
          ],
        ),

        // ==========================================================
        // RESPONSIVE BODY
        // ==========================================================

        body: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            // Jika layar handphone / mode potret (< 950 dp)
            if (constraints.maxWidth < 950) {
              return _buildMobile();
            }

            // Jika layar besar / desktop (>= 950 dp)
            return _buildDesktop();
          },
        ),
      ),
    );
  }

  // ==============================================================
  // MOBILE (Tampilan Potret / HP yang dirapikan agar tidak kepanjangan)
  // ==============================================================

  Widget _buildMobile() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            HeaderBanner(
              courses: _courses,
            ),
            const SizedBox(height: 20),
            _buildFilter(),
            const SizedBox(height: 18),
            ..._filteredCourses.map(
              (course) {
                return Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: SizedBox(
                    height: 306,
                    child: CourseCard(
                      course: course,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // DESKTOP (Banner Kiri + 3 Kolom Card di Kanan)
  // ==============================================================

  Widget _buildDesktop() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // Banner Kiri
          SizedBox(
            width: 350,
            child: HeaderBanner(
              courses: _courses,
            ),
          ),

          const SizedBox(width: 24),

          // Course Kanan (3 Kolom)
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                _buildFilter(),
                const SizedBox(height: 18),
                _buildCourseGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // GRID 3 KOLOM (UNTUK DESKTOP)
  // ==============================================================

  Widget _buildCourseGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount:
          _filteredCourses.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 306,
      ),
      itemBuilder: (
        context,
        index,
      ) {
        return CourseCard(
          course:
              _filteredCourses[index],
        );
      },
    );
  }

  // ==============================================================
  // FILTER CHIP
  // ==============================================================

  Widget _buildFilter() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ChoiceChip(
          label: const Text('Semua'),
          selected:
              _selectedFilter == 'Semua',
          avatar:
              _selectedFilter == 'Semua'
                  ? const Icon(
                      Icons.check,
                      size: 18,
                    )
                  : null,
          onSelected: (_) {
            setState(() {
              _selectedFilter =
                  'Semua';
            });
          },
        ),
        ChoiceChip(
          label: const Text('Teori'),
          selected:
              _selectedFilter == 'Teori',
          onSelected: (_) {
            setState(() {
              _selectedFilter =
                  'Teori';
            });
          },
        ),
        ChoiceChip(
          label: const Text(
            'Praktikum',
          ),
          selected:
              _selectedFilter ==
                  'Praktikum',
          onSelected: (_) {
            setState(() {
              _selectedFilter =
                  'Praktikum';
            });
          },
        ),
      ],
    );
  }
}