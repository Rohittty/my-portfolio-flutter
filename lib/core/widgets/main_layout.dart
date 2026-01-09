import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/core/widgets/nav_bar.dart';
import 'package:my_portfolio/core/widgets/nav_drawer.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/games/presentation/widgets/game_overlay.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Determine screen type
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      // On mobile, show an AppBar with a transparent background to hold the menu button
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'ROHIT ADVANI',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppTheme.neonAccent,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            )
          : null,
      drawer: isMobile ? const NavDrawer() : null,
      // Desktop: Use stack to overlay nav bar and games. Mobile: Just the child + games.
      body: Stack(
        children: [
          isMobile ? child : Stack(children: [child, const FloatingNavBar()]),
          const GameOverlay(),
        ],
      ),
    );
  }
}
