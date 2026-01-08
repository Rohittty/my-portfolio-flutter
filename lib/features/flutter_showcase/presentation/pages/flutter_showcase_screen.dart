import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/widgets/app_gallery.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/widgets/code_playground.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/widgets/package_showcase.dart';

class FlutterShowcaseScreen extends StatelessWidget {
  const FlutterShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Showcase"),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mobile Experiences",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppTheme.flutterPrimary,
              ),
            ),
            const Gap(8),
            Text(
              "High-performance, pixel-perfect native apps",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Gap(48),

            // App Gallery (Tilt Effect will be here)
            Text(
              "App Gallery",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            const AppGallery(),

            const Gap(48),

            // Code Playground
            Text(
              "Interactive Code Playground",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            const CodePlayground(),

            const Gap(48),

            // Package Showcase
            Text(
              "Open Source Packages",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            const PackageShowcase(),
          ],
        ),
      ),
    );
  }
}
