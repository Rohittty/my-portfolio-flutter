import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "WHAT I ",
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "DO",
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.neonAccent,
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            "Bridging the Gap Between Code and Cloud",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
          const Gap(48),
          const ResponsiveLayout(
            mobileBody: Column(
              children: [
                _ServiceCard(
                  title: "Mobile Engineering",
                  icon: FontAwesomeIcons.mobileScreen,
                  color: AppTheme.flutterPrimary,
                  description:
                      "Crafting pixel-perfect, high-performance cross-platform applications using Flutter. smooth 120fps animations and robust state management.",
                  techs: ["Flutter", "Dart", "Firebase", "Riverpod"],
                ),
                Gap(24),
                _ServiceCard(
                  title: "Cloud Architecture",
                  icon: FontAwesomeIcons.cloud,
                  color: AppTheme.devOpsPrimary,
                  description:
                      "Designing scalable, resilient cloud infrastructure. Automating deployments and ensuring 99.99% uptime with modern DevOps practices.",
                  techs: ["AWS", "Docker", "K8s", "Terraform"],
                ),
              ],
            ),
            desktopBody: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _ServiceCard(
                    title: "Mobile Engineering",
                    icon: FontAwesomeIcons.mobileScreen,
                    color: AppTheme.flutterPrimary,
                    description:
                        "Crafting pixel-perfect, high-performance cross-platform applications using Flutter. Smooth 120fps animations and robust state management.",
                    techs: ["Flutter", "Dart", "Firebase", "Riverpod"],
                  ),
                ),
                Gap(32),
                Expanded(
                  child: _ServiceCard(
                    title: "Cloud Architecture",
                    icon: FontAwesomeIcons.cloud,
                    color: AppTheme.devOpsPrimary,
                    description:
                        "Designing scalable, resilient cloud infrastructure. Automating deployments and ensuring 99.99% uptime with modern DevOps practices.",
                    techs: ["AWS", "Docker", "K8s", "Terraform"],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> techs;

  const _ServiceCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.techs,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: 200.ms,
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withValues(alpha: 0.1)
                : AppTheme.cardSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? widget.color : Colors.white10,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.2),
                  blurRadius: 32,
                  offset: const Offset(0, 16),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, size: 32, color: widget.color),
              ),
              const Gap(24),
              Text(
                widget.title,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Gap(16),
              Text(
                widget.description,
                style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
              ),
              const Gap(32),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.techs
                    .map(
                      (t) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.color.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          t,
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            color: widget.color,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
