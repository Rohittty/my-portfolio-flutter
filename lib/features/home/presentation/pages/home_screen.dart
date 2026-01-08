import 'package:flutter/material.dart';

import 'package:my_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:my_portfolio/features/home/presentation/widgets/featured_projects.dart';
import 'package:my_portfolio/features/home/presentation/widgets/skills_showcase.dart';
import 'package:my_portfolio/features/home/presentation/widgets/live_metrics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
            FeaturedProjects(),
            SkillsShowcase(),
            LiveMetrics(),
            // Add other sections here
          ],
        ),
      ),
    );
  }
}
