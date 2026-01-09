import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class WorkflowSection extends StatelessWidget {
  const WorkflowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.darkerBackground,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "THE PIPELINE",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 14,
              color: AppTheme.neonAccent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const Gap(16),
          Text(
            "Code to Cloud Workflow",
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const Gap(64),
          const ResponsiveLayout(
            mobileBody: Column(
              children: [
                _WorkflowCard(
                  step: "01",
                  title: "Code",
                  icon: FontAwesomeIcons.code,
                  description: "Writing clean, scalable Dart & backend logic.",
                  color: AppTheme.flutterPrimary,
                ),
                _Connector(isVertical: true),
                _WorkflowCard(
                  step: "02",
                  title: "Build",
                  icon: FontAwesomeIcons.cubes,
                  description: "Dockerizing apps & services for consistency.",
                  color: Colors.orangeAccent,
                ),
                _Connector(isVertical: true),
                _WorkflowCard(
                  step: "03",
                  title: "Test",
                  icon: FontAwesomeIcons.vial,
                  description: "Automated unit, widget, and integration tests.",
                  color: Colors.purpleAccent,
                ),
                _Connector(isVertical: true),
                _WorkflowCard(
                  step: "04",
                  title: "Deploy",
                  icon: FontAwesomeIcons.rocket,
                  description:
                      "CI/CD pipelines to AWS, Play Store & App Store.",
                  color: AppTheme.devOpsPrimary,
                ),
                _Connector(isVertical: true),
                _WorkflowCard(
                  step: "05",
                  title: "Monitor",
                  icon: FontAwesomeIcons.chartLine,
                  description: "Real-time logging, crash analytics & scaling.",
                  color: Colors.tealAccent,
                ),
              ],
            ),
            desktopBody: Wrap(
              alignment: WrapAlignment.center,
              spacing: 32,
              runSpacing: 32,
              children: [
                _WorkflowCard(
                  step: "01",
                  title: "Code",
                  icon: FontAwesomeIcons.code,
                  description: "Writing clean, scalable\nDart & backend logic.",
                  color: AppTheme.flutterPrimary,
                ),
                _WorkflowCard(
                  step: "02",
                  title: "Build",
                  icon: FontAwesomeIcons.cubes,
                  description: "Dockerizing apps &\nservices for consistency.",
                  color: Colors.orangeAccent,
                ),
                _WorkflowCard(
                  step: "03",
                  title: "Test",
                  icon: FontAwesomeIcons.vial,
                  description:
                      "Automated unit, widget,\nand integration tests.",
                  color: Colors.purpleAccent,
                ),
                _WorkflowCard(
                  step: "04",
                  title: "Deploy",
                  icon: FontAwesomeIcons.rocket,
                  description:
                      "CI/CD pipelines to AWS,\nPlay Store & App Store.",
                  color: AppTheme.devOpsPrimary,
                ),
                _WorkflowCard(
                  step: "05",
                  title: "Monitor",
                  icon: FontAwesomeIcons.chartLine,
                  description: "Real-time logging,\nanalytics & scaling.",
                  color: Colors.tealAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkflowCard extends StatefulWidget {
  final String step;
  final String title;
  final IconData icon;
  final String description;
  final Color color;

  const _WorkflowCard({
    required this.step,
    required this.title,
    required this.icon,
    required this.description,
    required this.color,
  });

  @override
  State<_WorkflowCard> createState() => _WorkflowCardState();
}

class _WorkflowCardState extends State<_WorkflowCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 200.ms,
        width: 180,
        height: 220,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.color.withValues(alpha: 0.1)
              : AppTheme.cardSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? widget.color : Colors.white10,
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.color.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, color: widget.color, size: 24),
            ),
            const Gap(16),
            Text(
              widget.title,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Gap(8),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white60,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Connector extends StatelessWidget {
  final bool isVertical;

  const _Connector({this.isVertical = false});

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return Container(
        height: 40,
        width: 2,
        color: Colors.white10,
        margin: const EdgeInsets.symmetric(vertical: 8),
      );
    }
    return Container(
      width: 40,
      height: 2,
      color: Colors.white10,
      margin: const EdgeInsets.only(top: 110), // Align with center of card
    );
  }
}
