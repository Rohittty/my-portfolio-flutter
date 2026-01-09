import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ProjectDetailScreen extends StatefulWidget {
  final String projectId;

  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Mock Data based on ID
    final isDevOps = widget.projectId.startsWith('d');
    final title = isDevOps ? "CloudScale CI/CD Pipeline" : "HealthTrack Pro";
    final color = isDevOps ? AppTheme.devOpsPrimary : AppTheme.flutterPrimary;
    final icon = isDevOps
        ? FontAwesomeIcons.cloud
        : FontAwesomeIcons.mobileScreen;

    final images = List.generate(3, (i) => "Screenshot ${i + 1}");
    final metrics = isDevOps
        ? [
            {"label": "Deployments/Day", "value": "150+"},
            {"label": "Build Time", "value": "3.2min"},
            {"label": "Success Rate", "value": "99.8%"},
          ]
        : [
            {"label": "Active Users", "value": "50K+"},
            {"label": "App Rating", "value": "4.8★"},
            {"label": "Downloads", "value": "100K+"},
          ];

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
          const Gap(16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Header
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 32 : 64,
                    horizontal: 32,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withValues(alpha: 0.2), Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        size: isMobile ? 50 : 80,
                        color: color,
                      ).animate().scale().fadeIn(),
                      const Gap(32),
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 32 : 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.greenAccent),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.greenAccent,
                                    shape: BoxShape.circle,
                                  ),
                                )
                                .animate(onPlay: (c) => c.repeat())
                                .fadeOut(duration: 1.seconds),
                            const Gap(8),
                            Text(
                              "LIVE PRODUCTION",
                              style: GoogleFonts.jetBrainsMono(
                                color: Colors.greenAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Metrics Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: metrics.map((metric) {
                  return Expanded(
                    child: _MetricCard(
                      label: metric["label"]!,
                      value: metric["value"]!,
                      color: color,
                    ),
                  );
                }).toList(),
              ),
            ),

            // Content Body
            Container(
              constraints: const BoxConstraints(maxWidth: 900),
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tech Stack
                  Text("TECH STACK", style: _headerStyle),
                  const Gap(16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _TechBadge("Flutter", AppTheme.flutterPrimary),
                      _TechBadge("Firebase", Colors.orangeAccent),
                      if (isDevOps) _TechBadge("AWS EKS", Colors.orange),
                      if (isDevOps)
                        _TechBadge("Terraform", Colors.purpleAccent),
                      if (isDevOps) _TechBadge("Docker", Colors.blueAccent),
                      if (!isDevOps) _TechBadge("Riverpod", Colors.blue),
                    ],
                  ),
                  const Gap(48),

                  // The Challenge
                  Text("THE CHALLENGE", style: _headerStyle),
                  const Gap(16),
                  Text(
                    isDevOps
                        ? "Scaling the CI/CD pipeline to handle 150+ daily deployments across multiple environments while maintaining sub-5-minute build times. The legacy Jenkins setup suffered from resource contention and inconsistent builds."
                        : "Creating a seamless health tracking experience that works offline-first, syncs across devices, and provides real-time insights. The app needed to handle complex data visualizations while maintaining 60fps performance.",
                    style: _bodyStyle,
                  ),
                  const Gap(48),

                  // The Solution
                  Text("THE SOLUTION", style: _headerStyle),
                  const Gap(16),
                  Text(
                    isDevOps
                        ? "Implemented a cloud-native CI/CD pipeline using GitHub Actions and AWS ECS. Containerized all build steps with Docker, enabling parallel execution and consistent environments. Integrated automated testing and security scanning at every stage."
                        : "Built with Flutter's BLoC pattern for state management and Hive for local storage. Implemented custom chart widgets optimized for mobile performance. Used WorkManager for background sync and Firebase for real-time collaboration features.",
                    style: _bodyStyle,
                  ),
                  const Gap(48),

                  // Gallery
                  Text("PROJECT GALLERY", style: _headerStyle),
                  const Gap(24),

                  // Image Carousel
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: color.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 80,
                                color: color.withValues(alpha: 0.3),
                              ),
                              const Gap(16),
                              Text(
                                images[_currentImageIndex],
                                style: GoogleFonts.jetBrainsMono(
                                  color: Colors.white54,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Navigation Arrows
                        if (images.length > 1) ...[
                          Positioned(
                            left: 16,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _currentImageIndex =
                                        (_currentImageIndex - 1) %
                                        images.length;
                                  });
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _currentImageIndex =
                                        (_currentImageIndex + 1) %
                                        images.length;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],

                        // Indicators
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: _currentImageIndex == index ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentImageIndex == index
                                      ? color
                                      : Colors.white30,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ).animate(key: ValueKey(index)).fadeIn();
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Gap(64),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.github),
                          label: const Text("VIEW CODE"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.all(20),
                          ),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.rocket),
                          label: const Text("LIVE DEMO"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(20),
                          ),
                        ),
                      ),
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

  TextStyle get _headerStyle => GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppTheme.neonAccent,
    letterSpacing: 2,
  );

  TextStyle get _bodyStyle =>
      GoogleFonts.inter(fontSize: 18, height: 1.6, color: Colors.white70);
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardSurface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ).animate().fadeIn().scale(),
          const Gap(8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.white54),
          ),
        ],
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
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.firaCode(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.2, end: 0);
  }
}
