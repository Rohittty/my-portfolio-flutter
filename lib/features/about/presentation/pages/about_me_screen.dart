import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/core/widgets/responsive_layout.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/about/presentation/widgets/interactive_resume.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Me"),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bio Section
            ResponsiveLayout(
              mobileBody: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white24,
                      backgroundImage: AssetImage(
                        AppConstants.profileImageDevOps,
                      ),
                    ),
                  ),
                  const Gap(32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.cardSurface.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, I'm Rohit",
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                        const Gap(16),
                        Text(
                          "Highly motivated Software and DevOps Developer with experience in building scalable mobile applications and automating cloud infrastructure. Skilled in Flutter, Dart, Firebase, RESTful APIs, and AWS. Passionate about solving real-world challenges through innovative, efficient, and secure digital solutions.",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontSize: 16, height: 1.6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              desktopBody: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white24,
                    backgroundImage: AssetImage(
                      AppConstants.profileImageDevOps,
                    ),
                  ),
                  const Gap(32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, I'm Rohit",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const Gap(16),
                        Text(
                          "Highly motivated Software and DevOps Developer with experience in building scalable mobile applications and automating cloud infrastructure. Skilled in Flutter, Dart, Firebase, RESTful APIs, and AWS. Passionate about solving real-world challenges through innovative, efficient, and secure digital solutions.",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(48),

            // Experience Timeline
            Text(
              "Experience",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(24),
            const InteractiveResume(),
          ],
        ),
      ),
    );
  }
}
