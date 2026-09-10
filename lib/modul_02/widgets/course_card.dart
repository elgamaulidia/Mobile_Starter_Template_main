import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,

      elevation: 2,

      color: theme.brightness == Brightness.dark
          ? const Color(0xFF1E2933)
          : const Color(0xFFEEF1F5),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: theme.brightness == Brightness.dark
              ? Colors.white.withOpacity(0.05)
              : const Color(0xFFE1E5EA),
        ),
      ),

      clipBehavior: Clip.antiAlias,

      child: InkWell(
        onTap: () {
          _showCourseDetail(context);
        },

        child: Stack(
          children: [
            // ======================================================
            // CONTENT
            // ======================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                18,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // ==================================================
                  // CODE
                  // ==================================================

                  Text(
                    course.code,

                    style: const TextStyle(
                      color: Color(0xFF28658F),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ==================================================
                  // NAME
                  // ==================================================

                  Text(
                    course.name,

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 18,
                      height: 1.25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // DOSEN
                  // ==================================================

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 19,
                        color: theme
                            .colorScheme
                            .onSurfaceVariant,
                      ),

                      const SizedBox(width: 9),

                      Expanded(
                        child: Text(
                          course.lecturer,

                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            color: theme
                                .colorScheme
                                .onSurfaceVariant,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 9),

                  // ==================================================
                  // RUANG
                  // ==================================================

                  Row(
                    children: [
                      Icon(
                        Icons.meeting_room_outlined,
                        size: 19,
                        color: theme
                            .colorScheme
                            .onSurfaceVariant,
                      ),

                      const SizedBox(width: 9),

                      Expanded(
                        child: Text(
                          course.room,

                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            color: theme
                                .colorScheme
                                .onSurfaceVariant,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // ==================================================
                  // PROGRESS
                  // ==================================================

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        'Progres Sesi',

                        style: TextStyle(
                          color:
                              theme.colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),

                      Text(
                        '${(course.progress * 100).toInt()}%',

                        style: TextStyle(
                          color:
                              theme.colorScheme.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10),

                    child: LinearProgressIndicator(
                      value: course.progress,

                      minHeight: 7,

                      backgroundColor:
                          const Color(0xFFD2E2F0),

                      valueColor:
                          const AlwaysStoppedAnimation<
                              Color>(
                        Color(0xFF2D6D91),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ======================================================
            // BADGE SKS
            //
            // STACK + POSITIONED
            // ======================================================

            Positioned(
              top: 14,
              right: 14,

              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFD1E7FA),
                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: Text(
                  '${course.sks} SKS',

                  style: const TextStyle(
                    color: Color(0xFF214A69),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // BOTTOM SHEET
  // ==============================================================

  void _showCourseDetail(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor:
          theme.colorScheme.surface,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.45,
          maxChildSize: 0.90,

          expand: false,

          builder: (
            context,
            scrollController,
          ) {
            return SingleChildScrollView(
              controller: scrollController,

              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // ==================================================
                  // HANDLE
                  // ==================================================

                  Center(
                    child: Container(
                      width: 45,
                      height: 5,

                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ==================================================
                  // COURSE TITLE
                  // ==================================================

                  Text(
                    course.code,

                    style: const TextStyle(
                      color: Color(0xFF28658F),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    course.name,

                    style: theme
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // INFO
                  // ==================================================

                  _DetailRow(
                    icon: Icons.person_outline,
                    title: 'Dosen',
                    value: course.lecturer,
                  ),

                  _DetailRow(
                    icon: Icons.school_outlined,
                    title: 'SKS',
                    value: '${course.sks} SKS',
                  ),

                  _DetailRow(
                    icon: Icons.meeting_room_outlined,
                    title: 'Ruangan',
                    value: course.room,
                  ),

                  _DetailRow(
                    icon: Icons.category_outlined,
                    title: 'Kategori',
                    value: course.type,
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // SILABUS
                  // ==================================================

                  Text(
                    'Silabus Mata Kuliah',

                    style: theme
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 12),

                  ...course.syllabus.asMap().entries.map(
                    (entry) {
                      final index =
                          entry.key + 1;

                      final item =
                          entry.value;

                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),

                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            CircleAvatar(
                              radius: 14,

                              backgroundColor:
                                  theme.colorScheme
                                      .primaryContainer,

                              child: Text(
                                '$index',

                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.bold,
                                  color: theme
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                item,

                                style: theme
                                    .textTheme
                                    .bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // ==================================================
                  // TUTUP
                  // ==================================================

                  SizedBox(
                    width: double.infinity,

                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        'Tutup Rincian',
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ==================================================================
// DETAIL ROW
// ==================================================================

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Icon(
            icon,
            size: 20,
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 75,

            child: Text(
              title,

              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}