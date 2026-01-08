import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class InteractiveResume extends StatelessWidget {
  const InteractiveResume({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Professional Timeline",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(24),
          _ResumeItem(
            year: "2024 - Present",
            role: "Senior DevOps Engineer",
            company: "Tech Corp",
            description:
                "Leading cloud infrastructure modernization and implementing GitOps pipelines.",
            color: Colors.greenAccent,
          ),
          const Gap(16),
          _ResumeItem(
            year: "2021 - 2024",
            role: "Flutter Developer",
            company: "App Solutions",
            description:
                "Developed and shipped 5+ cross-platform mobile applications for enterprise clients.",
            color: Colors.blueAccent,
          ),
          const Gap(16),
          _ResumeItem(
            year: "2019 - 2021",
            role: "Systems Administrator",
            company: "StartUp Inc",
            description:
                "Managed Linux servers and automated deployments using Bash and Python.",
            color: Colors.purpleAccent,
          ),
        ],
      ),
    );
  }
}

class _ResumeItem extends StatelessWidget {
  final String year;
  final String role;
  final String company;
  final String description;
  final Color color;

  const _ResumeItem({
    required this.year,
    required this.role,
    required this.company,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withOpacity(0.5)),
              ),
              child: Text(
                year,
                style: GoogleFonts.jetBrainsMono(fontSize: 12, color: color),
              ),
            ),
            Container(width: 2, height: 40, color: Colors.white10),
          ],
        ),
        const Gap(16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  company,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.white70),
                ),
                const Gap(8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
