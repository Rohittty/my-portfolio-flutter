import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child:
          Container(
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NavBarItem(
                          icon: Icons.home_rounded,
                          label: "Home",
                          route: AppConstants.routeHome,
                        ),
                        const SizedBox(width: 8),
                        _NavBarItem(
                          icon: FontAwesomeIcons.layerGroup,
                          label: "Projects",
                          route: AppConstants.routeDevOps,
                        ),
                        const SizedBox(width: 8),
                        _NavBarItem(
                          icon: FontAwesomeIcons.mobileScreen,
                          label: "Showcase",
                          route: AppConstants.routeFlutter,
                        ),
                        const SizedBox(width: 8),
                        _NavBarItem(
                          icon: Icons.hub_rounded,
                          label: "Hybrid",
                          route: AppConstants.routeHybrid,
                        ),
                        const SizedBox(width: 8),

                        _NavBarItem(
                          icon: Icons.person_rounded,
                          label: "About",
                          route: AppConstants.routeAbout,
                        ),
                        const SizedBox(width: 8),
                        _NavBarItem(
                          icon: Icons.mail_rounded,
                          label: "Contact",
                          route: AppConstants.routeContact,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: -1, end: 0, curve: Curves.easeOutBack),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String route;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.toString();
    final bool isSelected = currentRoute == widget.route;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.neonAccent.withValues(alpha: 0.2)
                : _isHovered
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? AppTheme.neonAccent.withValues(alpha: 0.5)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: isSelected
                    ? AppTheme.neonAccent
                    : (_isHovered ? Colors.white : Colors.white70),
                size: 20,
              ),
              if (isSelected || _isHovered)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.label,
                    style: GoogleFonts.outfit(
                      color: isSelected ? AppTheme.neonAccent : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
