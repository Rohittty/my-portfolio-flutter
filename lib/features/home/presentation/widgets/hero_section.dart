import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _mousePos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final center = Offset(size.width / 2, size.height / 2);

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePos = (event.position - center) / 1000;
        });
      },
      child: Container(
        height: 800,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(color: AppTheme.darkerBackground),
        child: Stack(
          children: [
            // Layer 1: Animated Grid (Deepest)
            Positioned.fill(
              child: CustomPaint(
                painter: _ArchitectGridPainter(_controller, _mousePos),
              ),
            ),

            // Layer 2: Floating Code Snippets (Parallax)
            Positioned(
              left: size.width * 0.1,
              top: size.height * 0.2,
              child:
                  _CodeSnippet(
                        "class DigitalArchitect extends Human {...}",
                        Colors.blueAccent,
                      )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: 0, end: 20, duration: 4.seconds),
            ),
            Positioned(
              right: size.width * 0.15,
              bottom: size.height * 0.3,
              child:
                  _CodeSnippet(
                        "kubectl apply -f world_domination.yaml",
                        Colors.greenAccent,
                      )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(
                        begin: 0,
                        end: -30,
                        duration: 5.seconds,
                        delay: 1.seconds,
                      ),
            ),

            // Layer 3: Main Content (Center)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.neonAccent),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "SYSTEM_ONLINE",
                      style: GoogleFonts.jetBrainsMono(
                        color: AppTheme.neonAccent,
                        fontSize: 12,
                      ),
                    ),
                  ).animate().fadeIn().scale(),
                  const Gap(24),
                  _TitleText(
                    "ARCHITECTING",
                    AppTheme.devOpsPrimary,
                    offset: -_mousePos * 50,
                  ),
                  _TitleText(
                    "& CODING",
                    AppTheme.flutterPrimary,
                    offset: -_mousePos * 30,
                  ),
                  const Gap(32),
                  Text(
                    AppConstants.heroTagline,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.white70,
                      letterSpacing: 1.2,
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                  const Gap(40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SocialButton(FontAwesomeIcons.github, "GitHub"),
                      const Gap(16),
                      _SocialButton(FontAwesomeIcons.linkedin, "LinkedIn"),
                    ],
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.5, end: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;
  final Color color;
  final Offset offset;

  const _TitleText(this.text, this.color, {required this.offset});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child:
          Text(
                text,
                style: GoogleFonts.outfit(
                  fontSize: 80,
                  fontWeight: FontWeight.w900,
                  height: 0.9,
                  color: Colors.transparent,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 0),
                      color: color,
                      blurRadius: 20,
                    ),
                  ],
                  decoration: TextDecoration.none,
                ),
              )
              .animate()
              .tint(color: Colors.white, duration: 1.seconds)
              .shimmer(duration: 2.seconds, delay: 3.seconds),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  final String code;
  final Color color;

  const _CodeSnippet(this.code, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        code,
        style: GoogleFonts.jetBrainsMono(color: color, fontSize: 12),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialButton(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _ArchitectGridPainter extends CustomPainter {
  final AnimationController controller;
  final Offset mousePos;

  _ArchitectGridPainter(this.controller, this.mousePos)
    : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    final spacing = 40.0;
    final offset = controller.value * spacing; // Moving effect

    // Draw Vertical Lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0) + mousePos * (x - size.width / 2) * 0.1,
        Offset(x, size.height) + mousePos * (x - size.width / 2) * 0.1,
        paint,
      );
    }

    // Draw Horizontal Lines with movement
    for (double y = -spacing; y < size.height + spacing; y += spacing) {
      double dy = (y + offset) % (size.height + spacing);
      if (dy < 0) dy += size.height;
      canvas.drawLine(
        Offset(0, dy) + mousePos * (dy - size.height / 2) * 0.1,
        Offset(size.width, dy) + mousePos * (dy - size.height / 2) * 0.1,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ArchitectGridPainter oldDelegate) => true;
}
