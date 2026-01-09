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
            "Experience & Education",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(24),
          _ResumeItem(
            year: "Jan 2025 - Present",
            role: "Software Developer",
            company: "Infutrix Technologies",
            description:
                "Designed and developed mobile apps using Flutter & Firebase. Integrated RESTful APIs for complex functionalities like tax calculators and appointment booking. Enhanced app performance and security.",
            color: AppTheme.flutterPrimary,
          ),
          const Gap(16),
          _ResumeItem(
            year: "May 2024 - June 2024",
            role: "DevOps Intern",
            company: "Celebal Technologies",
            description:
                "Built and managed CI/CD pipelines using AWS DevOps. Automating code testing and deployment workflows. Assisted in containerization and cloud infrastructure automation.",
            color: AppTheme.devOpsPrimary,
          ),
          const Gap(16),
          _ResumeItem(
            year: "2021 - 2025",
            role: "Bachelor in Technology",
            company: "Poornima College of Engineering",
            description:
                "Computer Science Engineering. CGPA: 8.2\nActive participant in hackathons and coding societies.",
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
