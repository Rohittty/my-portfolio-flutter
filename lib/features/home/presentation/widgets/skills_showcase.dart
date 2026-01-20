import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class SkillsShowcase extends StatelessWidget {
  const SkillsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TECHNICAL ARSENAL",
            style: GoogleFonts.jetBrainsMono(
              color: AppTheme.neonAccent,
              fontSize: 14,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideX(begin: -0.1, end: 0),
          const Gap(16),
          Text(
            "My Stack",
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const Gap(40),
          const ResponsiveLayout(
            mobileBody: Column(
              children: [
                _SkillCard(
                  title: "Programming",
                  icon: FontAwesomeIcons.code,
                  color: AppTheme.flutterPrimary,
                  skills: [
                    "Flutter",
                    "Dart",
                    "Firebase",
                    "RESTful APIs",
                    "C++",
                    "Java",
                    "Python",
                    "SQL",
                    "MongoDB",
                    "Docker",
                  ],
                ),
                Gap(24),
                _SkillCard(
                  title: "DevOps",
                  icon: FontAwesomeIcons.infinity,
                  color: AppTheme.devOpsPrimary,
                  skills: ["AWS", "CI/CD Pipelines", "Git", "Postman"],
                ),
                Gap(24),
                _SkillCard(
                  title: "Professional Skills",
                  icon: FontAwesomeIcons.userTie,
                  color: Colors.amberAccent,
                  skills: [
                    "Agile Development",
                    "Problem Solving",
                    "Cloud Infrastructure",
                    "Debugging",
                    "Clean Code",
                    "Automation",
                    "Collaboration",
                  ],
                ),
              ],
            ),
            desktopBody: Wrap(
              spacing: 32,
              runSpacing: 32,
              children: [
                _SkillCard(
                  title: "Programming",
                  icon: FontAwesomeIcons.code,
                  color: AppTheme.flutterPrimary,
                  skills: [
                    "Flutter",
                    "Dart",
                    "Firebase",
                    "RESTful APIs",
                    "C++",
                    "Java",
                    "Python",
                    "SQL",
                    "MongoDB",
                    "Docker",
                  ],
                ),
                _SkillCard(
                  title: "DevOps",
                  icon: FontAwesomeIcons.infinity,
                  color: AppTheme.devOpsPrimary,
                  skills: ["AWS", "CI/CD Pipelines", "Git", "Postman"],
                ),
                _SkillCard(
                  title: "Professional Skills",
                  icon: FontAwesomeIcons.userTie,
                  color: Colors.amberAccent,
                  skills: [
                    "Agile Development",
                    "Problem Solving",
                    "Cloud Infrastructure",
                    "Debugging",
                    "Clean Code",
                    "Automation",
                    "Collaboration",
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> skills;

  const _SkillCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 200.ms,
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 350),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.color.withValues(alpha: 0.05)
              : AppTheme.cardSurface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? widget.color : Colors.white10,
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.color.withValues(alpha: 0.1),
                blurRadius: 32,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.icon, color: widget.color, size: 28),
            ),
            const Gap(24),
            Text(
              widget.title,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Gap(24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.skills
                  .map((skill) => _SkillPill(skill: skill, color: widget.color))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillPill extends StatelessWidget {
  final String skill;
  final Color color;

  const _SkillPill({required this.skill, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        skill,
        style: GoogleFonts.inter(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
