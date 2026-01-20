import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class FactoryDetailScreen extends StatelessWidget {
  const FactoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Factory Management', style: GoogleFonts.outfit()),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 16 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 28,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.devOpsPrimary.withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.devOpsPrimary.withValues(alpha: 0.18),
                    ),
                  ),
                  child: isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.devOpsPrimary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.factory,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                ).animate().fadeIn().scale(),
                                const Gap(16),
                                Expanded(
                                  child: Text(
                                    'Factory Management System',
                                    style: GoogleFonts.outfit(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ).animate().fadeIn(delay: 100.ms),
                                ),
                              ],
                            ),
                            const Gap(16),
                            Text(
                              'End-to-end industrial automation and inventory tracking system.',
                              style: GoogleFonts.inter(color: Colors.white70),
                            ).animate().fadeIn(delay: 200.ms),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.devOpsPrimary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.factory,
                                size: 32,
                                color: Colors.white,
                              ),
                            ).animate().fadeIn().scale(),
                            const Gap(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Factory Management System',
                                    style: GoogleFonts.outfit(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ).animate().fadeIn(delay: 100.ms),
                                  const Gap(6),
                                  Text(
                                    'End-to-end industrial automation and inventory tracking system.',
                                    style: GoogleFonts.inter(
                                      color: Colors.white70,
                                    ),
                                  ).animate().fadeIn(delay: 200.ms),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
                const Gap(20),
                const Gap(18),
                // Quick bullets
                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Role',
                            style: GoogleFonts.jetBrainsMono(
                              color: AppTheme.neonAccent,
                            ),
                          ),
                          const Gap(6),
                          Text(
                            'Full Stack Engineer',
                            style: GoogleFonts.inter(color: Colors.white70),
                          ),
                          const Gap(12),
                          Text(
                            'Highlights',
                            style: GoogleFonts.jetBrainsMono(
                              color: AppTheme.neonAccent,
                            ),
                          ),
                          const Gap(6),
                          _bulleted([
                            'Real-time Inventory',
                            'IoT Integration',
                            'Automated Reporting',
                          ]),
                        ],
                      ),
                      const Gap(24),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _chip('Flutter'),
                          _chip('Node.js'),
                          _chip('MongoDB'),
                          _chip('IoT'),
                        ],
                      ).animate().fadeIn(delay: 200.ms),
                    ] else ...[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Role',
                              style: GoogleFonts.jetBrainsMono(
                                color: AppTheme.neonAccent,
                              ),
                            ),
                            const Gap(6),
                            Text(
                              'Full Stack Engineer',
                              style: GoogleFonts.inter(color: Colors.white70),
                            ),
                            const Gap(12),
                            Text(
                              'Highlights',
                              style: GoogleFonts.jetBrainsMono(
                                color: AppTheme.neonAccent,
                              ),
                            ),
                            const Gap(6),
                            _bulleted([
                              'Real-time Inventory',
                              'IoT Integration',
                              'Automated Reporting',
                            ]),
                          ],
                        ),
                      ),
                      const Gap(24),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _chip('Flutter'),
                          _chip('Node.js'),
                          _chip('MongoDB'),
                          _chip('IoT'),
                        ],
                      ).animate().fadeIn(delay: 200.ms),
                    ],
                  ],
                ),
                const Gap(24),
                Text(
                  'Challenge',
                  style: GoogleFonts.jetBrainsMono(color: AppTheme.neonAccent),
                ),
                const Gap(8),
                Text(
                  'Digitizing legacy factory operations to track inventory and machine status in real-time.',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
                const Gap(24),
                Text(
                  'Solution',
                  style: GoogleFonts.jetBrainsMono(color: AppTheme.neonAccent),
                ),
                const Gap(8),
                Text(
                  'Developed a cross-platform Flutter app connected to IoT sensors and a Node.js backend for live dashboards and alerts.',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
                const Gap(32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _chip(String label) =>
      Chip(label: Text(label), backgroundColor: Colors.white10);

  Widget _bulleted(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: AppTheme.neonAccent),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      s,
                      style: GoogleFonts.inter(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
