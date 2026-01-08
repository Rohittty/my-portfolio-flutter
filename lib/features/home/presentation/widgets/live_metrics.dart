import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class LiveMetrics extends StatefulWidget {
  const LiveMetrics({super.key});

  @override
  State<LiveMetrics> createState() => _LiveMetricsState();
}

class _LiveMetricsState extends State<LiveMetrics> {
  late Timer _timer;

  // Simulated initial stats
  int _activeProjects = 12;
  int _commits = 8432;
  int _downloads = 12500;
  int _dockerPulls = 5400;

  @override
  void initState() {
    super.initState();
    // Simulate live updates
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _commits += 1;
          if (timer.tick % 4 == 0) _downloads += 5;
          if (timer.tick % 6 == 0) _dockerPulls += 2;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      color: AppTheme.darkerBackground,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.circle, color: AppTheme.neonAccent, size: 12),
              const Gap(8),
              Text(
                "LIVE SYSTEM METRICS",
                style: GoogleFonts.jetBrainsMono(
                  color: AppTheme.neonAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const Gap(48),
          ResponsiveLayout(
            mobileBody: Column(
              children: [
                _MetricCard(
                  title: "Active Projects",
                  value: "$_activeProjects",
                  icon: FontAwesomeIcons.codeBranch,
                  color: const Color(0xFF1769FF),
                ),
                const Gap(16),
                _MetricCard(
                  title: "GitHub Commits",
                  value: "$_commits",
                  icon: FontAwesomeIcons.github,
                  color: Colors.white,
                ),
                const Gap(16),
                _MetricCard(
                  title: "Package Downloads",
                  value: "$_downloads",
                  icon: FontAwesomeIcons.dartLang,
                  color: AppTheme.flutterPrimary,
                ),
                const Gap(16),
                _MetricCard(
                  title: "Docker Pulls",
                  value: "$_dockerPulls",
                  icon: FontAwesomeIcons.docker,
                  color: AppTheme.devOpsPrimary,
                ),
              ],
            ),
            desktopBody: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MetricCard(
                  title: "Active Projects",
                  value: "$_activeProjects",
                  icon: FontAwesomeIcons.codeBranch,
                  color: const Color(0xFF64B5F6),
                ),
                _MetricCard(
                  title: "GitHub Commits",
                  value: "$_commits",
                  icon: FontAwesomeIcons.github,
                  color: Colors.white,
                ),
                _MetricCard(
                  title: "Package Downloads",
                  value: "$_downloads",
                  icon: FontAwesomeIcons.dartLang,
                  color: AppTheme.flutterPrimary,
                ),
                _MetricCard(
                  title: "Docker Pulls",
                  value: "$_dockerPulls",
                  icon: FontAwesomeIcons.docker,
                  color: AppTheme.devOpsPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardSurface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const Gap(16),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Gap(8),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
