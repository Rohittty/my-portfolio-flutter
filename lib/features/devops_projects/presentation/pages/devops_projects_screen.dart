import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/devops_projects/presentation/widgets/devops_project_card.dart';
import 'package:my_portfolio/features/devops_projects/presentation/widgets/infra_simulator.dart';

class DevOpsProjectsScreen extends ConsumerStatefulWidget {
  const DevOpsProjectsScreen({super.key});

  @override
  ConsumerState<DevOpsProjectsScreen> createState() =>
      _DevOpsProjectsScreenState();
}

class _DevOpsProjectsScreenState extends ConsumerState<DevOpsProjectsScreen> {
  final List<String> _filters = [
    "All",
    "Kubernetes",
    "AWS",
    "Azure",
    "CI/CD",
    "Monitoring",
  ];
  String _activeFilter = "All";

  // Mock Data
  final List<Map<String, dynamic>> _projects = [
    {
      "title": "CI/CD Pipeline Automation",
      "uptime": "99.9%",
      "techStack": ["AWS DevOps", "GitHub Actions", "Docker"],
      "category": "CI/CD",
    },
    {
      "title": "Cloud Infra Automation",
      "uptime": "Stable",
      "techStack": ["AWS", "Terraform", "CloudWatch"],
      "category": "AWS",
    },
    {
      "title": "K8s Orchestration",
      "uptime": "99.95%",
      "techStack": ["Docker", "Kubernetes", "EKS"],
      "category": "Kubernetes",
    },
    {
      "title": "Secure Cloud Ops",
      "uptime": "Secured",
      "techStack": ["IAM", "VPC", "WAF"],
      "category": "AWS",
    },
    {
      "title": "Hybrid Cloud Monitor",
      "uptime": "Active",
      "techStack": ["Azure", "Prometheus", "Grafana"],
      "category": "Monitoring",
    },
    {
      "title": "Serverless API Gateway",
      "uptime": "99.99%",
      "techStack": ["AWS Lambda", "API Gateway", "Python"],
      "category": "AWS",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter logic
    final displayedProjects = _activeFilter == "All"
        ? _projects
        : _projects
              .where(
                (p) =>
                    (p["category"] as String) == _activeFilter ||
                    (p["techStack"] as List).contains(_activeFilter),
              )
              .toList();

    return Scaffold(
      backgroundColor: AppTheme.darkerBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          final isTablet =
              constraints.maxWidth > 600 && constraints.maxWidth <= 900;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Terminal Header
              SliverAppBar(
                backgroundColor: AppTheme.darkBackground,
                floating: true,
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  title:
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.devOpsPrimary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: Text(
                          "> root@portfolio:~/projects/devops",
                          style: GoogleFonts.firaCode(
                            fontSize: 12,
                            color: AppTheme.devOpsPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ).animate().fadeIn().moveX(
                        begin: -20,
                        end: 0,
                        duration: 800.ms,
                      ),
                  centerTitle: true,
                  background: Container(color: AppTheme.darkerBackground),
                ),
              ),

              // Filter Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: isDesktop
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: _filters.map((filter) {
                        final isSelected = _activeFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () => setState(() => _activeFilter = filter),
                            borderRadius: BorderRadius.circular(8),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.devOpsPrimary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.devOpsPrimary
                                      : Colors.white24,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.devOpsPrimary
                                              .withValues(alpha: 0.4),
                                          blurRadius: 10,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Text(
                                filter,
                                style: GoogleFonts.jetBrainsMono(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              // Project Grid
              SliverPadding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width < 600 ? 16 : 32,
                ),
                sliver: isDesktop || isTablet
                    ? SliverMasonryGrid.count(
                        crossAxisCount: isDesktop ? 3 : 2,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                        childCount: displayedProjects.length,
                        itemBuilder: (context, index) {
                          final project = displayedProjects[index];
                          return DevOpsProjectCard(
                                title: project['title'],
                                uptime: project['uptime'],
                                techStack: project['techStack'],
                              )
                              .animate()
                              .fadeIn(delay: (index * 100).ms)
                              .slideY(begin: 0.1);
                        },
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final project = displayedProjects[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child:
                                DevOpsProjectCard(
                                      title: project['title'],
                                      uptime: project['uptime'],
                                      techStack: project['techStack'],
                                    )
                                    .animate()
                                    .fadeIn(delay: (index * 100).ms)
                                    .slideY(begin: 0.1),
                          );
                        }, childCount: displayedProjects.length),
                      ),
              ),

              const SliverToBoxAdapter(child: Gap(48)),

              // Simulator Section Header
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "// SYSTEM_SIMULATION",
                    style: GoogleFonts.firaCode(
                      color: Colors.white24,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: Gap(24)),

              // Simulator
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 0,
                  ),
                  child: InfraSimulator(),
                ),
              ),

              const SliverToBoxAdapter(child: Gap(80)),
            ],
          );
        },
      ),
    );
  }
}
