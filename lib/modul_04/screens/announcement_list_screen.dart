import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/announcement.dart';
import '../providers/announcement_provider.dart';
import '../widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends ConsumerWidget {
  const AnnouncementListScreen({super.key});

  static const List<String> _categories = [
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Announcement>> asyncAnnouncements =
        ref.watch(announcementsProvider);

    final String selectedCategory =
        ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: () {
              ref.invalidate(announcementsProvider);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  final bool isSelected =
                      selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: const Color(0xFFE0F2FE),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? const Color(0xFF0284C7)
                            : const Color(0xFF475569),
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          ref
                              .read(
                                selectedCategoryProvider.notifier,
                              )
                              .state = category;
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Color(0xFFE2E8F0),
          ),
          Expanded(
            child: asyncAnnouncements.when(
              loading: () {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xFF0284C7),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Memuat pengumuman dari server...',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) {
                return _buildGagal(
                  context,
                  ref,
                  error,
                );
              },
              data: (pengumuman) {
                if (pengumuman.isEmpty) {
                  return _buildKosong();
                }

                return RefreshIndicator(
                  color: const Color(0xFF0284C7),
                  onRefresh: () async {
                    ref.invalidate(announcementsProvider);
                    await ref.read(announcementsProvider.future);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: pengumuman.length,
                    itemBuilder: (context, index) {
                      final Announcement item = pengumuman[index];

                      return AnnouncementCard(
                        announcement: item,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AnnouncementDetailScreen(
                                announcement: item,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGagal(
    BuildContext context,
    WidgetRef ref,
    Object error,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 64,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            const Text(
              'Gagal Memuat Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString().replaceAll('Exception: ', ''),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ref.invalidate(announcementsProvider);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0284C7),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKosong() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Color(0xFF94A3B8),
          ),
          SizedBox(height: 16),
          Text(
            'Belum ada pengumuman.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}