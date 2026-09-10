import 'package:flutter/material.dart';
import '../models/course.dart';

class HeaderBanner extends StatelessWidget {
  final List<Course> courses;

  const HeaderBanner({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    final totalSKS = courses.fold<int>(
      0,
      (total, course) => total + course.sks,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF087DB5),
            Color(0xFF0878AD),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // SEMESTER + NOTIFIKASI
          // =====================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Semester 5 (2026/2027)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 27,
              ),
            ],
          ),

          const SizedBox(height: 22),

          // =====================================================
          // NAMA MAHASISWA
          // =====================================================
          Text(
            'Selamat Datang, Elga Maulidia Akbari (362558302130)',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 15,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 8),

          // =====================================================
          // JUDUL
          // =====================================================
          const Text(
            'Dashboard Akademik & Proyek',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          // =====================================================
          // STATISTIK
          // =====================================================
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatChip(
                icon: Icons.school_rounded,
                text: '$totalSKS SKS',
              ),

              const _StatChip(
                icon: Icons.star_rounded,
                text: 'IPK 3.85',
              ),

              const _StatChip(
                icon: Icons.calendar_month_rounded,
                text: '100% Hadir',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================
// STAT CHIP
// =============================================================

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _StatChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 17,
          ),

          const SizedBox(width: 6),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}