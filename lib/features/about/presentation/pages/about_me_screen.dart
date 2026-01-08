import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/about/presentation/widgets/interactive_resume.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Me"),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bio Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white24,
                  backgroundImage: AssetImage(AppConstants.profileImageDevOps),
                ),
                const Gap(32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, I'm Rohit",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const Gap(16),
                      Text(
                        "I am a passionate DevOps Engineer and Flutter Developer with a knack for building scalable systems and beautiful user interfaces. With 5 years of experience, I bridge the gap between operations and frontend development.",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(48),

            // Interactive Resume
            Text(
              "Career Journey",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            const InteractiveResume(),

            const Gap(48),

            // Tech Stack Grid
            Text(
              "Technical Arsenal",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _TechBadge("Flutter", Colors.blue),
                _TechBadge("Dart", Colors.blueAccent),
                _TechBadge("Kubernetes", Colors.blueGrey),
                _TechBadge("Docker", Colors.blue),
                _TechBadge("AWS", Colors.orange),
                _TechBadge("Terraform", Colors.purple),
                _TechBadge("Go", Colors.teal),
                _TechBadge("Python", Colors.yellow),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _TechBadge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
