import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'dart:ui'; // For ImageFilter

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
      duration: const Duration(seconds: 20),
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
    final isDesktop = size.width > 900;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePos = (event.position - center) / center.dy;
        });
      },
      child: Container(
        height: 900, // Taller hero section
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppTheme.darkerBackground,
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [const Color(0xFF1E1E28), AppTheme.darkerBackground],
          ),
        ),
        child: Stack(
          children: [
            // Layer 1: Animated Grid (Deepest)
            Positioned.fill(
              child: CustomPaint(
                painter: _ArchitectGridPainter(_controller, _mousePos),
              ),
            ),

            // Layer 2: Ambient Glows
            Positioned(
              left: -100,
              top: 100,
              child: _AmbientGlow(
                color: AppTheme.devOpsPrimary.withValues(alpha: 0.15),
                radius: 300,
              ),
            ),
            Positioned(
              right: -100,
              bottom: 100,
              child: _AmbientGlow(
                color: AppTheme.flutterPrimary.withValues(alpha: 0.15),
                radius: 300,
              ),
            ),

            // Layer 3: Floating Abstract Tech Elements
            if (isDesktop) ...[
              Positioned(
                left: size.width * 0.1,
                top: size.height * 0.2,
                child:
                    const _TechCard(
                          icon: FontAwesomeIcons.server,
                          label: "K8s Cluster",
                          status: "Deploying...",
                          color: Colors.greenAccent,
                        )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .moveY(begin: 0, end: 20, duration: 6.seconds),
              ),
              Positioned(
                right: size.width * 0.1,
                bottom: size.height * 0.3,
                child:
                    const _TechCard(
                          icon: FontAwesomeIcons.mobileScreen,
                          label: "Flutter Build",
                          status: "Compiling...",
                          color: Colors.blueAccent,
                        )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .moveY(
                          begin: 0,
                          end: -30,
                          duration: 7.seconds,
                          delay: 1.seconds,
                        ),
              ),
            ],

            // Layer 4: Main Content (Center)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        border: Border.all(
                          color: AppTheme.neonAccent.withValues(alpha: 0.5),
                        ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.neonAccent.withValues(alpha: 0.2),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                                Icons.circle,
                                color: AppTheme.neonAccent,
                                size: 8,
                              )
                              .animate(onPlay: (c) => c.repeat())
                              .fadeIn(duration: 1.seconds)
                              .then()
                              .fadeOut(duration: 1.seconds),
                          const Gap(10),
                          Text(
                            "SOFTWARE & DEVOPS DEVELOPER",
                            style: GoogleFonts.jetBrainsMono(
                              color: AppTheme.neonAccent,
                              fontSize: 12,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn().scale(),
                    const Gap(32),

                    // Main Title Parallax
                    Transform.translate(
                          offset: -_mousePos * 20,
                          child: Column(
                            children: [
                              _GradientText(
                                "Building Scalable Apps",
                                style: GoogleFonts.outfit(
                                  fontSize: isDesktop ? 72 : 48,
                                  fontWeight: FontWeight.w900,
                                  height: 1.0,
                                  letterSpacing: -2,
                                ),
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Color(0xFFE0E0E0)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              _GradientText(
                                "from UI to Cloud",
                                style: GoogleFonts.outfit(
                                  fontSize: isDesktop ? 72 : 48,
                                  fontWeight: FontWeight.w900,
                                  height: 1.0,
                                  letterSpacing: -2,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.flutterPrimary,
                                    AppTheme.devOpsPrimary,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 800.ms)
                        .slideY(begin: 0.2, end: 0),

                    const Gap(32),
                    SizedBox(
                      width: 700,
                      child: Text(
                        "Highly motivated software and DevOps Developer with experience in building scalable mobile applications and automating cloud infrastructure. Skilled in Flutter, Dart, Firebase, RESTful APIs, and AWS.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isDesktop ? 18 : 16,
                          color: Colors.white60,
                          height: 1.6,
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
                    const Gap(48),

                    // Buttons
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _PrimaryButton(
                          onPressed: () {}, 
                          label: "View Work",
                          icon: Icons.arrow_downward_rounded,
                        ),
                        const Gap(24),
                        _SocialRow(),
                      ],
                    ).animate().fadeIn(delay: 900.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  final Color color;
  final double radius;

  const _AmbientGlow({required this.color, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
      ),
    );
  }
}

class _TechCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;
  final Color color;

  const _TechCard({
    required this.icon,
    required this.label,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    status,
                    style: GoogleFonts.jetBrainsMono(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const _GradientText(this.text, {required this.style, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const _PrimaryButton({
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Gap(8),
          Icon(icon, size: 18),
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialButton(FontAwesomeIcons.github, "GitHub"),
        const Gap(16),
        _SocialButton(FontAwesomeIcons.linkedin, "LinkedIn"),
        const Gap(16),
        _SocialButton(FontAwesomeIcons.envelope, "Email"),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;

  const _SocialButton(this.icon, this.tooltip);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {}, 
      tooltip: tooltip,
      icon: Icon(icon, color: Colors.white70, size: 24),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        padding: const EdgeInsets.all(12),
        shape: const CircleBorder(),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
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
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    final spacing = 50.0;

    // Parallax effect
    final dx = mousePos.dx * 20;
    final dy = mousePos.dy * 20;

    // Draw Vertical Lines
    for (double x = 0; x < size.width + 100; x += spacing) {
      canvas.drawLine(
        Offset(x + dx, -100),
        Offset(x + dx, size.height + 100),
        paint,
      );
    }

    // Draw Horizontal Lines (Perspective sort of)
    for (double y = 0; y < size.height + 100; y += spacing) {
      canvas.drawLine(
        Offset(-100, y + dy),
        Offset(size.width + 100, y + dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ArchitectGridPainter oldDelegate) => true;
}
