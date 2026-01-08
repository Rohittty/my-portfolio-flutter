import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/widgets/hybrid_project_card.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/widgets/architecture_viewer.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/widgets/deployment_timeline.dart';

class HybridProjectsScreen extends StatelessWidget {
  const HybridProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hybrid Projects"),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Full-Stack Solutions",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: AppTheme.neonAccent),
            ),
            const Gap(8),
            Text(
              "End-to-end applications bridging Flutter and DevOps",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Gap(48),

            // Case Studies
            Text(
              "Case Studies",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            SizedBox(
              height: 420,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  HybridProjectCard(
                    title: "E-Commerce Microservices",
                    description:
                        "A complete e-commerce platform with Flutter mobile app and Go microservices backend on Kubernetes.",
                    techStack: ["Flutter", "Go", "gRPC", "K8s", "PostgreSQL"],
                    color: Colors.blueAccent,
                  ),
                  Gap(24),
                  HybridProjectCard(
                    title: "IoT Fleet Management",
                    description:
                        "Real-time vehicle tracking dashboard processing MQTT streams from edge devices.",
                    techStack: [
                      "Flutter Web",
                      "Python",
                      "MQTT",
                      "AWS IoT",
                      "TimescaleDB",
                    ],
                    color: Colors.tealAccent,
                  ),
                  Gap(24),
                  HybridProjectCard(
                    title: "FinTech Banking App",
                    description:
                        "Secure banking application with biometric auth and CI/CD compliant with financial regulations.",
                    techStack: [
                      "Flutter",
                      "Java Spring",
                      "Vault",
                      "Jenkins",
                      "OIDC",
                    ],
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
            ),

            const Gap(48),

            // Architecture Toggle
            Text(
              "System Architecture",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            const ArchitectureViewer(),

            const Gap(48),

            // Deployment Timeline
            Text(
              "Deployment Roadmap",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            const DeploymentTimeline(),
          ],
        ),
      ),
    );
  }
}
