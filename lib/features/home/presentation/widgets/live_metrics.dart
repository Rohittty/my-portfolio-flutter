import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'dart:ui'; // For ImageFilter

class CodingProfile extends StatelessWidget {
  const CodingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.darkerBackground,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      child: Column(
        children: [
          Text(
            "COMPETITIVE PROGRAMMING & OPEN SOURCE",
            style: GoogleFonts.jetBrainsMono(
              color: AppTheme.neonAccent,
              fontSize: 14,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          Text(
            "Coding Profile",
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Gap(48),
          const ResponsiveLayout(
            mobileBody: Column(
              children: [_LeetCodeCard(), Gap(24), _GitHubStatsCard()],
            ),
            desktopBody: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_LeetCodeCard(), Gap(32), _GitHubStatsCard()],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeetCodeCard extends StatelessWidget {
  const _LeetCodeCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(FontAwesomeIcons.code, color: Colors.orangeAccent, size: 28),
              const Gap(12),
              Text(
                "Competitive Coding",
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Gap(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem("LeetCode", "Active", Colors.orangeAccent),
              _StatItem("Hackerrank", "5★", Colors.greenAccent),
              _StatItem("GFG", "Solved", Colors.blueAccent),
            ],
          ),
          const Gap(24),
          Divider(color: Colors.white12),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Solved",
                style: GoogleFonts.inter(color: Colors.white60),
              ),
              Text(
                "400+",
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GitHubStatsCard extends StatelessWidget {
  const _GitHubStatsCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(FontAwesomeIcons.trophy, color: Colors.amber, size: 28),
              const Gap(12),
              Text(
                "Achievements",
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Gap(24),
          _AchievementRow(
            "Patent Published",
            "PawsTrack (IoT) 2024",
            FontAwesomeIcons.certificate,
            Colors.purpleAccent,
          ),
          const Gap(16),
          _AchievementRow(
            "Semi-Finalist",
            "Smart India Hackathon '23",
            FontAwesomeIcons.medal,
            Colors.amber,
          ),
          const Gap(24),
          Divider(color: Colors.white12),
        ],
      ),
    );
  }
}

class _AchievementRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _AchievementRow(this.title, this.subtitle, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
            ),
            Text(
              subtitle,
              style: GoogleFonts.jetBrainsMono(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.cardSurface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: Colors.white60),
        ),
      ],
    );
  }
}
