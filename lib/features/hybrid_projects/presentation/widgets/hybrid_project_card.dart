import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HybridProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> techStack;
  final Color color;

  const HybridProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.techStack,
    required this.color,
  });

  @override
  State<HybridProjectCard> createState() => _HybridProjectCardState();
}

class _HybridProjectCardState extends State<HybridProjectCard> {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  bool _isHovered = false;

  void _onHover(PointerEvent details, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final position = details.localPosition - center;

    setState(() {
      _rotateY = (position.dx / (size.width / 2)) * 0.1;
      _rotateX = -(position.dy / (size.height / 2)) * 0.1;
    });
  }

  void _onExit(PointerEvent details) {
    setState(() {
      _rotateX = 0.0;
      _rotateY = 0.0;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: _onExit,
      onHover: (e) {
        final size = context.size ?? Size.zero;
        _onHover(e, size);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotateX)
          ..rotateY(_rotateY),
        child: Container(
          width: 380,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.cardSurface.withValues(alpha: 0.6),
                AppTheme.cardSurface.withValues(alpha: 0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.5)
                  : Colors.white10,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Icon
              Container(
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.color.withValues(alpha: 0.2),
                      widget.color.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GridPainter(color: widget.color),
                      ),
                    ),
                    // Icon
                    Center(
                      child: Icon(Icons.hub, size: 72, color: widget.color)
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scale(
                            duration: 2.seconds,
                            begin: const Offset(0.9, 0.9),
                          ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      widget.description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(20),

                    // Tech Stack Layers
                    Text(
                      "// TECH_STACK",
                      style: GoogleFonts.firaCode(
                        fontSize: 10,
                        color: Colors.white38,
                      ),
                    ),
                    const Gap(8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.techStack
                          .map((tech) => _TechChip(tech, widget.color))
                          .toList(),
                    ),
                    const Gap(24),

                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text("View Case Study"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: widget.color,
                          side: BorderSide(
                            color: widget.color.withValues(alpha: 0.5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final Color accentColor;

  const _TechChip(this.label, this.accentColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          color: accentColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;

  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..strokeWidth = 1;

    const spacing = 20.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
