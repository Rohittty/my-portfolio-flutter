import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class BbniaDetailScreen extends StatelessWidget {
  const BbniaDetailScreen({super.key});

  static const _playStoreUrl = 'https://play.google.com/store/apps/details?id=com.example.bbnia';

  Future<void> _openPlayStore(BuildContext context) async {
    final uri = Uri.parse(_playStoreUrl);
    final messenger = ScaffoldMessenger.of(context);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not open Play Store')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('BBNIA', style: GoogleFonts.outfit()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.flutterPrimary.withValues(alpha: 0.06), Colors.transparent],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.flutterPrimary.withValues(alpha: 0.12)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.flutterPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.description, size: 32, color: Colors.white),
                  ).animate().fadeIn().scale(),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('BBNIA', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)).animate().fadeIn(delay: 100.ms),
                        const Gap(6),
                        Text('Create professional resumes on mobile with live PDF preview and export.', style: GoogleFonts.inter(color: Colors.white70)).animate().fadeIn(delay: 200.ms),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _openPlayStore(context),
                    icon: const Icon(Icons.shop),
                    label: const Text('Open'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.neonAccent, foregroundColor: Colors.black),
                  ).animate().fadeIn(delay: 300.ms),
                ],
              ),
            ),
            const Gap(20),
            const Gap(18),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Role', style: GoogleFonts.jetBrainsMono(color: AppTheme.neonAccent)),
                      const Gap(6),
                      Text('Full-stack Mobile Developer', style: GoogleFonts.inter(color: Colors.white70)),
                      const Gap(12),
                      Text('Highlights', style: GoogleFonts.jetBrainsMono(color: AppTheme.neonAccent)),
                      const Gap(6),
                      _bulleted(['Template-driven PDF export', 'Cloud sync', 'One-tap share']),
                    ],
                  ),
                ),
                const Gap(24),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _chip('Flutter'),
                  _chip('PDF'),
                  _chip('Firebase'),
                ]).animate().fadeIn(delay: 200.ms),
              ],
            ),
            const Gap(24),
            Text('Challenge', style: GoogleFonts.jetBrainsMono(color: AppTheme.neonAccent)),
            const Gap(8),
            Text('Enable users to create professional resumes on mobile with accurate PDF rendering.', style: GoogleFonts.inter(color: Colors.white70)),
            const Gap(24),
            Text('Solution', style: GoogleFonts.jetBrainsMono(color: AppTheme.neonAccent)),
            const Gap(8),
            Text('Implemented template-driven PDF generation and live preview; added export and cloud sync features.', style: GoogleFonts.inter(color: Colors.white70)),
            const Gap(32),
            ElevatedButton.icon(
              onPressed: () => _openPlayStore(context),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Open in Play Store'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) => Chip(label: Text(label), backgroundColor: Colors.white10);

  Widget _bulleted(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline, size: 12, color: AppTheme.flutterPrimary),
                    const Gap(8),
                    Expanded(child: Text(s, style: GoogleFonts.inter(color: Colors.white70))),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
