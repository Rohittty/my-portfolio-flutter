import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'dart:ui'; // For ImageFilter

class FeaturedProjects extends StatelessWidget {
  const FeaturedProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      ProjectData(
        title: "TaxHelpDesk",
        description: "Mobile app for CA-related services & calculators.",
        devOpsStats: "AWS • REST APIs",
        flutterStats: "Appointment Booking • Calculators",
        icon: FontAwesomeIcons.calculator,
        tags: ["Flutter", "Firebase", "REST APIs", "AWS"],
        route: '/flutter/tax-help',
      ),
      ProjectData(
        title: "Isomeds",
        description: "E-commerce app for purchasing medicines.",
        devOpsStats: "Prescription Uploads",
        flutterStats: "Cart Management • Home Delivery",
        icon: FontAwesomeIcons.capsules,
        tags: ["Flutter", "Dart", "Firebase", "E-commerce"],
        route: '/flutter/isomeds',
      ),
      ProjectData(
        title: "BBNIA",
        description: "Resume building & hiring platform.",
        devOpsStats: "Subscription Model",
        flutterStats: "Resume Builder • Hiring Portal",
        icon: FontAwesomeIcons.fileContract,
        tags: ["Flutter", "REST APIs", "AWS", "Git"],
        route: '/flutter/bbnia',
      ),
      ProjectData(
        title: "Factory Management",
        description: "Industrial automation & inventory tracking.",
        devOpsStats: "IoT Integration",
        flutterStats: "Real-time Dashboard",
        icon: FontAwesomeIcons.industry,
        tags: ["Flutter", "Node.js", "IoT", "MongoDB"],
        route: '/project/factory-management',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                "Featured Projects",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideX(begin: -0.2, end: 0, curve: Curves.easeOut),
          const Gap(8),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.devOpsPrimary, AppTheme.flutterPrimary],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ).animate().scaleX(
            duration: 800.ms,
            alignment: Alignment.centerLeft,
            curve: Curves.easeInOut,
          ),
          const Gap(40),
          ResponsiveLayout(
            mobileBody: Column(
              children: projects
                  .asMap()
                  .entries
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: ProjectCard(
                        key: ValueKey(entry.value.title),
                        data: entry.value,
                        index: entry.key,
                        onNavigate: () {
                          final id = entry.value.title.toLowerCase().replaceAll(
                            ' ',
                            '-',
                          );
                          context.push('/project/devops-$id');
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
            tabletBody: Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: projects
                  .asMap()
                  .entries
                  .map(
                    (entry) => SizedBox(
                      width: (MediaQuery.of(context).size.width - 100) / 2,
                      child: ProjectCard(
                        key: ValueKey(entry.value.title),
                        data: entry.value,
                        index: entry.key,
                        onNavigate: () {
                          final id = entry.value.title.toLowerCase().replaceAll(
                            ' ',
                            '-',
                          );
                          context.push('/project/devops-$id');
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
            desktopBody: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: projects
                  .asMap()
                  .entries
                  .map(
                    (entry) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ProjectCard(
                          key: ValueKey(entry.value.title),
                          data: entry.value,
                          index: entry.key,
                          onNavigate: () {
                            if (entry.value.route != null) {
                              context.push(entry.value.route!);
                            }
                          },
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectData {
  final String title;
  final String description;
  final String devOpsStats;
  final String flutterStats;
  final IconData icon;
  final List<String> tags;
  final String? route;

  ProjectData({
    required this.title,
    required this.description,
    required this.devOpsStats,
    required this.flutterStats,
    required this.icon,
    required this.tags,
    this.route,
  });
}

class ProjectCard extends StatefulWidget {
  final ProjectData data;
  final VoidCallback onNavigate;
  final int index;

  const ProjectCard({
    required this.data,
    required this.onNavigate,
    required this.index,
    super.key,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onNavigate,
            child:
                AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      transform: Matrix4.identity()
                        ..scale(_isHovered ? 1.05 : 1.0)
                        ..translate(0.0, _isHovered ? -10.0 : 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            isDark
                                ? const Color(0xFF1E1E2E).withValues(alpha: 0.8)
                                : Colors.white.withValues(alpha: 0.9),
                            isDark
                                ? const Color(0xFF2A2A40).withValues(alpha: 0.9)
                                : Colors.grey.shade100,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _isHovered
                                ? AppTheme.flutterPrimary.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.1),
                            blurRadius: _isHovered ? 20 : 10,
                            offset: Offset(0, _isHovered ? 10 : 5),
                          ),
                          if (_isHovered)
                            BoxShadow(
                              color: AppTheme.devOpsPrimary.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 30,
                              offset: const Offset(5, 5),
                            ),
                        ],
                        border: Border.all(
                          color: _isHovered
                              ? AppTheme.flutterPrimary.withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.1),
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.white.withValues(
                                                alpha: 0.05,
                                              )
                                            : Colors.black.withValues(
                                                alpha: 0.05,
                                              ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        widget.data.icon,
                                        size: 28,
                                        color: _isHovered
                                            ? AppTheme.flutterPrimary
                                            : (isDark
                                                  ? Colors.white70
                                                  : Colors.black87),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_outward_rounded,
                                      color: _isHovered
                                          ? AppTheme.devOpsPrimary
                                          : Colors.grey.shade400,
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                Text(
                                  widget.data.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _isHovered
                                        ? (isDark ? Colors.white : Colors.black)
                                        : (isDark
                                              ? Colors.white70
                                              : Colors.black87),
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  widget.data.description,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade600,
                                  ),
                                ),
                                const Gap(20),
                                _buildTechStack(isDark),
                                const Gap(20),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: _isHovered
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: isDark
                                                  ? Colors.white.withValues(
                                                      alpha: 0.1,
                                                    )
                                                  : Colors.black.withValues(
                                                      alpha: 0.1,
                                                    ),
                                            ),
                                            const Gap(12),
                                            _buildStatRow(
                                              FontAwesomeIcons.server,
                                              widget.data.devOpsStats,
                                              AppTheme.devOpsPrimary,
                                              isDark,
                                            ),
                                            const Gap(8),
                                            _buildStatRow(
                                              FontAwesomeIcons.mobileButton,
                                              widget.data.flutterStats,
                                              AppTheme.flutterPrimary,
                                              isDark,
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .animate(target: _isHovered ? 1 : 0)
                    .shimmer(
                      duration: 1200.ms,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: (widget.index * 200).ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOut);
  }

  Widget _buildTechStack(bool isDark) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.data.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.1),
            ),
          ),
          child: Text(
            tag,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatRow(IconData icon, String text, Color color, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const Gap(8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
