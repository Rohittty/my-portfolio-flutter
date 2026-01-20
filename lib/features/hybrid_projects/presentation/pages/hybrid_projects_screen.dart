import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/widgets/hybrid_project_card.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/widgets/architecture_viewer.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/widgets/deployment_timeline.dart';

class HybridProjectsScreen extends StatelessWidget {
  const HybridProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkerBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Hero Header
          SliverAppBar(
            backgroundColor: AppTheme.darkBackground,
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Hybrid Projects",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.neonAccent.withValues(alpha: 0.1),
                      AppTheme.darkerBackground,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(40),
                      Icon(Icons.layers, size: 64, color: AppTheme.neonAccent)
                          .animate()
                          .scale(duration: 600.ms)
                          .shimmer(delay: 600.ms),
                      const Gap(8),
                      Text(
                        "Where Code Meets Cloud",
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width < 600 ? 16 : 32,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Case Studies Section
                Text(
                  "// FULL_STACK_SOLUTIONS",
                  style: GoogleFonts.firaCode(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.neonAccent,
                  ),
                ),
                const Gap(8),
                Text(
                  "End-to-end applications bridging Flutter and DevOps expertise.",
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
                ),
                const Gap(32),

                // Responsive Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 900;

                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: isDesktop
                          ? WrapAlignment.start
                          : WrapAlignment.center,
                      children: [
                        const HybridProjectCard(
                          title: "E-Commerce Microservices",
                          description:
                              "Complete e-commerce platform with Flutter mobile app and Go microservices backend on Kubernetes.",
                          techStack: [
                            "Flutter",
                            "Go",
                            "gRPC",
                            "K8s",
                            "PostgreSQL",
                          ],
                          color: Colors.blueAccent,
                        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
                        const HybridProjectCard(
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
                        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                        const HybridProjectCard(
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
                        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                        const HybridProjectCard(
                          title: "Factory Management System",
                          description:
                              "Industrial automation platform tracking inventory and machine status in real-time.",
                          techStack: [
                            "Flutter",
                            "Node.js",
                            "MongoDB",
                            "IoT",
                            "WebSocket",
                          ],
                          color: Colors.redAccent,
                        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                      ],
                    );
                  },
                ),

                const Gap(64),

                // Architecture Section
                Text(
                  "// SYSTEM_ARCHITECTURE",
                  style: GoogleFonts.firaCode(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.neonAccent,
                  ),
                ),
                const Gap(8),
                Text(
                  "Scalable, cloud-native architectures designed for performance.",
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
                ),
                const Gap(32),
                const ArchitectureViewer()
                    .animate()
                    .fadeIn(delay: 400.ms)
                    .slideY(begin: 0.1),

                const Gap(64),

                // Deployment Timeline
                Text(
                  "// DEPLOYMENT_ROADMAP",
                  style: GoogleFonts.firaCode(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.neonAccent,
                  ),
                ),
                const Gap(8),
                Text(
                  "From development to production—automated and reliable.",
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
                ),
                const Gap(32),
                const DeploymentTimeline()
                    .animate()
                    .fadeIn(delay: 500.ms)
                    .slideY(begin: 0.1),

                const Gap(80),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
