import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:my_portfolio/features/home/presentation/widgets/featured_projects.dart';
import 'package:my_portfolio/features/home/presentation/widgets/skills_showcase.dart';
import 'package:my_portfolio/features/home/presentation/widgets/live_metrics.dart';

import 'package:my_portfolio/features/home/presentation/widgets/workflow_section.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroSection(),

            const CodingProfile(),
            const WorkflowSection(),
            const FeaturedProjects(),
            const SkillsShowcase(),

            // Final Call to Action
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
              color: AppTheme.darkerBackground,
              child: Column(
                children: [
                  Text(
                    "Ready to Execute?",
                    style: GoogleFonts.outfit(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    "Whether it's deploying a K8s cluster or building a smooth Flutter app, I'm ready.",
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  ),
                  const Gap(32),
                  ElevatedButton(
                    onPressed: () {}, // TODO: Navigate to Contact
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.neonAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 24,
                      ),
                      textStyle: GoogleFonts.jetBrainsMono(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("INITIALIZE_CONTACT()"),
                  ),
                  const Gap(64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "© 2026 Rohit Advani. Built with ",
                        style: TextStyle(color: Colors.white38),
                      ),
                      Icon(Icons.favorite, size: 14, color: Colors.blueAccent),
                      Text(" Flutter", style: TextStyle(color: Colors.white38)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
