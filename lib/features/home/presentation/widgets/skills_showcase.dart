import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:gap/gap.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class SkillsShowcase extends StatelessWidget {
  const SkillsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Technical Arsenal",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(32),
          const ResponsiveLayout(
            mobileBody: _MobileSkills(),
            desktopBody: _DesktopSkills(),
          ),
        ],
      ),
    );
  }
}

class _DesktopSkills extends StatelessWidget {
  const _DesktopSkills();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _SkillCategory(
            title: "DevOps & Cloud",
            color: AppTheme.devOpsPrimary,
            skills: [
              _Skill("Kubernetes", 0.9),
              _Skill("AWS / Azure", 0.85),
              _Skill("Terraform", 0.95),
              _Skill("CI/CD (GitHub Actions)", 0.9),
              _Skill("Docker", 0.95),
            ],
          ),
        ),
        const Gap(40),
        Expanded(
          child: _SkillCategory(
            title: "Flutter & Mobile",
            color: AppTheme.flutterPrimary,
            skills: [
              _Skill("Dart", 0.95),
              _Skill("State Management (Riverpod)", 0.9),
              _Skill("Bloc/Cubit", 0.85),
              _Skill("Animations", 0.8),
              _Skill("Clean Architecture", 0.9),
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileSkills extends StatelessWidget {
  const _MobileSkills();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SkillCategory(
          title: "DevOps & Cloud",
          color: AppTheme.devOpsPrimary,
          skills: [
            _Skill("Kubernetes", 0.9),
            _Skill("AWS", 0.85),
            _Skill("Terraform", 0.95),
          ],
        ),
        const Gap(32),
        _SkillCategory(
          title: "Flutter & Mobile",
          color: AppTheme.flutterPrimary,
          skills: [
            _Skill("Dart", 0.95),
            _Skill("Riverpod", 0.9),
            _Skill("Animations", 0.8),
          ],
        ),
      ],
    );
  }
}

class _SkillCategory extends StatelessWidget {
  final String title;
  final Color color;
  final List<_Skill> skills;

  const _SkillCategory({
    required this.title,
    required this.color,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: color),
          ),
          const Gap(24),
          ...skills.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _SkillBar(skill: s, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  final _Skill skill;
  final Color color;

  const _SkillBar({required this.skill, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(skill.name, style: Theme.of(context).textTheme.bodyLarge),
            Text(
              "${(skill.level * 100).toInt()}%",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const Gap(8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(4),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.centerLeft,
                child:
                    Container(
                      height: 8,
                      width: constraints.maxWidth * skill.level,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ).animate().scaleX(
                      alignment: Alignment.centerLeft,
                      duration: 1000.ms,
                      curve: Curves.easeOutCubic,
                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Skill {
  final String name;
  final double level;
  _Skill(this.name, this.level);
}
