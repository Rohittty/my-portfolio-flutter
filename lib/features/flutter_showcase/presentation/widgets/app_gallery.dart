import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class AppGallery extends StatelessWidget {
  const AppGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 32,
      runSpacing: 32,
      alignment: WrapAlignment.center,
      children: [
        _TiltCard(
          appName: "TaxHelpDesk",
          description: "CA Services & Tools",
          color: Colors.blueAccent,
          icon: Icons.calculate,
        ),
        _TiltCard(
          appName: "Isomeds",
          description: "E-commerce Medicine",
          color: Colors.greenAccent,
          icon: Icons.medical_services,
        ),
        _TiltCard(
          appName: "BBNIA",
          description: "Resume Builder Platform",
          color: Colors.purpleAccent,
          icon: Icons.description,
        ),
      ],
    );
  }
}

class _TiltCard extends StatefulWidget {
  final String appName;
  final String description;
  final Color color;
  final IconData icon;

  const _TiltCard({
    required this.appName,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  State<_TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<_TiltCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;
  Animation<Alignment>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation?.value ?? Alignment.center;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(begin: _dragAlignment, end: Alignment.center),
    );

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(mass: 30, stiffness: 1, damping: 1);
    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.stop(),
      onExit: (e) => _runAnimation(Offset.zero, MediaQuery.of(context).size),
      onHover: (e) {
        final size = context.size ?? Size.zero;
        final center = Offset(size.width / 2, size.height / 2);
        final position = e.localPosition - center;

        setState(() {
          _dragAlignment = Alignment(
            position.dx / (size.width / 2),
            position.dy / (size.height / 2),
          );
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_dragAlignment.y * -0.2) // Tilt X based on Y pos
          ..rotateY(_dragAlignment.x * 0.2), // Tilt Y based on X pos
        alignment: Alignment.center,
        child: Container(
          width: 280,
          height: 500, // Phone aspect ratioish
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade800, width: 8),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
                // App Screen Content (Mock)
                Container(
                  color: AppTheme.darkBackground,
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        color: widget.color.withOpacity(0.1),
                        alignment: Alignment.center,
                        child: Icon(widget.icon, size: 48, color: widget.color),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 100,
                              color: Colors.white10,
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 14,
                              width: 200,
                              color: Colors.white10,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 14,
                              width: 160,
                              color: Colors.white10,
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white10,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white10,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Overlay text
                Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Text(
                        widget.appName,
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Hot Reload Label
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.flash_on,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
