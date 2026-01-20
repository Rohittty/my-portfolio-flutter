import 'package:go_router/go_router.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/core/widgets/main_layout.dart';
import 'package:my_portfolio/features/home/presentation/pages/home_screen.dart';
import 'package:my_portfolio/features/devops_projects/presentation/pages/devops_projects_screen.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/pages/flutter_showcase_screen.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/pages/tax_help_detail_screen.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/pages/isomeds_detail_screen.dart';
import 'package:my_portfolio/features/flutter_showcase/presentation/pages/bbnia_detail_screen.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/pages/hybrid_projects_screen.dart';
import 'package:my_portfolio/features/hybrid_projects/presentation/pages/factory_detail_screen.dart';
import 'package:my_portfolio/features/about/presentation/pages/about_me_screen.dart';
import 'package:my_portfolio/features/contact/presentation/pages/contact_screen.dart';
import 'package:my_portfolio/features/devops_projects/presentation/pages/project_detail_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppConstants.routeHome,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
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
            path: '/flutter/tax-help',
            builder: (context, state) => const TaxHelpDetailScreen(),
          ),
          GoRoute(
            path: '/flutter/isomeds',
            builder: (context, state) => const IsomedsDetailScreen(),
          ),
          GoRoute(
            path: '/flutter/bbnia',
            builder: (context, state) => const BbniaDetailScreen(),
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

          // Stacked Routes (Hide Shell if needed, or keep it)
          GoRoute(
            path: '/project/devops-:id',
            builder: (context, state) => const DevOpsProjectsScreen(),
          ),
          GoRoute(
            path: '/project/factory-management',
            builder: (context, state) => const FactoryDetailScreen(),
          ),
          GoRoute(
            path: '/project/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return ProjectDetailScreen(projectId: id);
            },
          ),
        ],
      ),
    ],
  );
}
