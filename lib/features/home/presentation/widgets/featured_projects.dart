import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'dart:math' as math;

class FeaturedProjects extends StatelessWidget {
  const FeaturedProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      _ProjectData(
        title: "CloudScale CI",
        description: "Automated K8s scaling pipeline",
        devOpsStats: "99.99% Uptime • Kubernetes",
        flutterStats: "Admin Dashboard App • 4.8★",
        icon: FontAwesomeIcons.cloud,
      ),
      _ProjectData(
        title: "HealthTrack",
        description: "HIPAA compliant monitoring",
        devOpsStats: "AWS • Terraform • Docker",
        flutterStats: "Patient App • Bluetooth",
        icon: FontAwesomeIcons.heartPulse,
      ),
      _ProjectData(
        title: "FinTech Flow",
        description: "High-frequency trading interface",
        devOpsStats: "Microservices • gRPC",
        flutterStats: "Real-time Charts • WebSocket",
        icon: FontAwesomeIcons.chartLine,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Featured Projects",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(24),
          ResponsiveLayout(
            mobileBody: Column(
              children: projects
                  .map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ProjectCard(data: p),
                    ),
                  )
                  .toList(),
            ),
            tabletBody: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: projects
                  .map(
                    (p) => SizedBox(
                      width: (MediaQuery.of(context).size.width - 100) / 2,
                      child: ProjectCard(data: p),
                    ),
                  )
                  .toList(),
            ),
            desktopBody: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: projects
                  .map(
                    (p) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProjectCard(data: p),
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

class _ProjectData {
  final String title;
  final String description;
  final String devOpsStats;
  final String flutterStats;
  final IconData icon;

  _ProjectData({
    required this.title,
    required this.description,
    required this.devOpsStats,
    required this.flutterStats,
    required this.icon,
  });
}

class ProjectCard extends StatefulWidget {
  final _ProjectData data;
  const ProjectCard({required this.data});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * math.pi;
            final isFrontVisible = angle < math.pi / 2;

            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: isFrontVisible
                  ? _buildFront()
                  : Transform(
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: _buildBack(),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.devOpsPrimary.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.data.icon, size: 48, color: AppTheme.devOpsPrimary),
          const Gap(16),
          Text(
            widget.data.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(8),
          Text(
            widget.data.devOpsStats,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(16),
          const Chip(label: Text("View DevOps Architecture")),
        ],
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: AppTheme.darkBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.flutterPrimary.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.mobile,
            size: 48,
            color: AppTheme.flutterPrimary,
          ),
          const Gap(16),
          Text(
            widget.data.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(8),
          Text(
            widget.data.flutterStats,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(16),
          const Chip(label: Text("See App Screens")),
        ],
      ),
    );
  }
}
