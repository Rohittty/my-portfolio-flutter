import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/widgets/app_gallery.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/widgets/interactive_playground.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/widgets/package_showcase.dart';

class FlutterShowcaseScreen extends StatelessWidget {
  const FlutterShowcaseScreen({super.key});

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
                "Flutter Showcase",
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
                      AppTheme.flutterPrimary.withValues(alpha: 0.1),
                      AppTheme.darkerBackground,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(40),
                      Icon(
                            Icons.flutter_dash,
                            size: 64,
                            color: AppTheme.flutterPrimary,
                          )
                          .animate()
                          .scale(duration: 600.ms)
                          .shimmer(delay: 600.ms),
                      const Gap(8),
                      Text(
                        "Native Performance, Infinite Creativity",
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
            padding: const EdgeInsets.all(32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Interactive Playground
                Text(
                  "// WIDGET_LAB",
                  style: GoogleFonts.firaCode(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.flutterPrimary,
                  ),
                ),
                const Gap(8),
                Text(
                  "Experiment with Flutter widgets in real-time. Adjust parameters and watch the magic happen.",
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
                ),
                const Gap(32),
                const InteractivePlayground(),

                const Gap(64),

                // App Gallery
                Text(
                  "// PRODUCTION_APPS",
                  style: GoogleFonts.firaCode(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.flutterPrimary,
                  ),
                ),
                const Gap(8),
                Text(
                  "High-performance, pixel-perfect native experiences built with Flutter.",
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
                ),
                const Gap(32),
                const AppGallery(),

                const Gap(64),

                // Package Showcase
                Text(
                  "// OPEN_SOURCE",
                  style: GoogleFonts.firaCode(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.flutterPrimary,
                  ),
                ),
                const Gap(8),
                Text(
                  "Contributing to the Flutter ecosystem with reusable packages.",
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
                ),
                const Gap(32),
                const PackageShowcase(),

                const Gap(80),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
