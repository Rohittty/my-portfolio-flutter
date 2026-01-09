import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:my_portfolio/features/home/presentation/widgets/featured_projects.dart';
import 'package:my_portfolio/features/home/presentation/widgets/skills_showcase.dart';
import 'package:my_portfolio/features/home/presentation/widgets/live_metrics.dart';

import 'package:my_portfolio/features/home/presentation/widgets/workflow_section.dart';
import 'package:my_portfolio/features/home/presentation/widgets/mobile_simulator_background.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Back Layer - Mobile Simulator
          const MobileSimulatorBackground(),

          // Front Layer - Content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const RepaintBoundary(child: HeroSection()),
                const RepaintBoundary(child: CodingProfile()),
                const RepaintBoundary(child: WorkflowSection()),
                const RepaintBoundary(child: FeaturedProjects()),
                const RepaintBoundary(child: SkillsShowcase()),

                // Final Call to Action
                const RepaintBoundary(child: _CTASection()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      color: AppTheme.darkerBackground,
      child: Column(
        children: [
          Text(
            "Ready to Execute?",
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Gap(16),
          Text(
            "Whether it's deploying a K8s cluster or building a smooth Flutter app, I'm ready.",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
          const Gap(32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.neonAccent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
              textStyle: GoogleFonts.jetBrainsMono(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text("INITIALIZE_CONTACT()"),
          ),
          const Gap(64),
          const _FooterSection(),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppTheme.neonAccent.withValues(alpha: 0.05),
          ],
        ),
        border: Border(
          top: BorderSide(color: AppTheme.neonAccent.withValues(alpha: 0.2)),
        ),
      ),
      child: Column(
        children: [
          // Social Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialButton(icon: Icons.code, label: "GitHub", onTap: () {}),
              const Gap(16),
              _SocialButton(icon: Icons.work, label: "LinkedIn", onTap: () {}),
              const Gap(16),
              _SocialButton(icon: Icons.email, label: "Email", onTap: () {}),
            ],
          ),
          const Gap(32),
          // Copyright
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "© 2026 Rohit Adwani • Built with ",
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white38,
                  fontSize: 14,
                ),
              ),
              const Icon(Icons.favorite, size: 16, color: Colors.redAccent),
              Text(
                " & Flutter",
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white38,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            "Crafted for Performance • Designed for Impact",
            style: GoogleFonts.inter(
              color: AppTheme.neonAccent.withValues(alpha: 0.5),
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.neonAccent.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.neonAccent
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _isHovered ? AppTheme.neonAccent : Colors.white70,
                size: 20,
              ),
              const Gap(8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  color: _isHovered ? AppTheme.neonAccent : Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
