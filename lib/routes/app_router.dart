import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/core/widgets/nav_bar.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/home/presentation/pages/home_screen.dart';
import 'package:my_portfolio/features/devops_projects/presentation/pages/devops_projects_screen.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/pages/flutter_showcase_screen.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/pages/hybrid_projects_screen.dart';
import 'package:my_portfolio/features/about/presentation/pages/about_me_screen.dart';
import 'package:my_portfolio/features/contact/presentation/pages/contact_screen.dart';
import 'package:my_portfolio/features/blog/presentation/pages/blog_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppConstants.routeHome,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            backgroundColor: AppTheme.darkBackground,
            body: Stack(children: [child, const FloatingNavBar()]),
          );
        },
        routes: [
          GoRoute(
            path: AppConstants.routeHome,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppConstants.routeDevOps,
            builder: (context, state) => const DevOpsProjectsScreen(),
          ),
          GoRoute(
            path: AppConstants.routeFlutter,
            builder: (context, state) => const FlutterShowcaseScreen(),
          ),
          GoRoute(
            path: AppConstants.routeHybrid,
            builder: (context, state) => const HybridProjectsScreen(),
          ),
          GoRoute(
            path: AppConstants.routeAbout,
            builder: (context, state) => const AboutMeScreen(),
          ),
          GoRoute(
            path: AppConstants.routeContact,
            builder: (context, state) => const ContactScreen(),
          ),
          // Blog Route
          GoRoute(
            path: AppConstants.routeBlog,
            builder: (context, state) => const BlogScreen(),
          ),
        ],
      ),
    ],
  );
}
