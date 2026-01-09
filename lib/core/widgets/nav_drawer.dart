import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.cardSurface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppTheme.devOpsPrimary,
                  child: Icon(Icons.code, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  "Navigation Node",
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _NavItem(
            icon: Icons.home,
            label: "Home / Landing",
            route: AppConstants.routeHome,
          ),
          _NavItem(
            icon: FontAwesomeIcons.server,
            label: "DevOps Projects",
            route: AppConstants.routeDevOps,
          ),
          _NavItem(
            icon: FontAwesomeIcons.mobile,
            label: "Flutter Showcase",
            route: AppConstants.routeFlutter,
          ),
          _NavItem(
            icon: Icons.layers,
            label: "Hybrid Solutions",
            route: AppConstants.routeHybrid,
          ),
          _NavItem(
            icon: Icons.person,
            label: "About Me",
            route: AppConstants.routeAbout,
          ),
          _NavItem(
            icon: Icons.mail,
            label: "Contact",
            route: AppConstants.routeContact,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = GoRouterState.of(context).uri.toString() == route;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.neonAccent : Colors.white70,
      ),
      title: Text(
        label,
        style: GoogleFonts.inter(
          color: isSelected ? AppTheme.neonAccent : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        context.go(route);
        Navigator.pop(context); // Close drawer
      },
      selected: isSelected,
      selectedTileColor: AppTheme.neonAccent.withValues(alpha: 0.1),
    );
  }
}
