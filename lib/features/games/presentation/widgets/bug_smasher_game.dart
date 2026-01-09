import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class BugSmasherGame extends StatefulWidget {
  const BugSmasherGame({super.key});

  @override
  State<BugSmasherGame> createState() => _BugSmasherGameState();
}

class _BugSmasherGameState extends State<BugSmasherGame>
    with TickerProviderStateMixin {
  int _score = 0;
  int _combo = 0;
  int _highScore = 0;
  List<Bug> _bugs = [];
  List<Particle> _particles = [];
  Timer? _spawner;
  Timer? _comboTimer;
  int _spawnInterval = 800;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _spawner = Timer.periodic(Duration(milliseconds: _spawnInterval), (timer) {
      if (!mounted) return;
      if (_bugs.length < 12) {
        setState(() {
          _bugs.add(
            Bug(
              position: Offset(
                Random().nextDouble() * 0.75 + 0.1,
                Random().nextDouble() * 0.75 + 0.1,
              ),
              speed: 1.0 + (_score / 500),
            ),
          );
        });
      }
      // Increase difficulty
      if (_score > 100 && _spawnInterval > 400) {
        _spawner?.cancel();
        _spawnInterval = max(400, _spawnInterval - 50);
        _startGame();
      }
    });
  }

  void _smashBug(int index, Offset position) {
    setState(() {
      _bugs.removeAt(index);
      _combo++;
      int points = 10 * _combo;
      _score += points;

      if (_score > _highScore) _highScore = _score;

      // Create particles
      for (int i = 0; i < 8; i++) {
        _particles.add(
          Particle(
            position: position,
            velocity: Offset(
              (Random().nextDouble() - 0.5) * 4,
              (Random().nextDouble() - 0.5) * 4,
            ),
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
        );
      }

      // Reset combo timer
      _comboTimer?.cancel();
      _comboTimer = Timer(const Duration(seconds: 2), () {
        if (mounted) setState(() => _combo = 0);
      });
    });

    // Remove particles after animation
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _particles.clear());
    });
  }

  @override
  void dispose() {
    _spawner?.cancel();
    _comboTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Score Display
        Positioned(
          top: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SCORE: $_score",
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
              ),
              if (_combo > 1)
                Text(
                  "COMBO x$_combo!",
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.orangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate(key: ValueKey(_combo)).shimmer().scale(),
              Text(
                "HIGH: $_highScore",
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Instructions
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Text(
            "🎯 Tap bugs to fix them! Build combos for bonus points!",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
          ),
        ),

        // Particles
        ..._particles.map(
          (particle) => Positioned(
            left: particle.position.dx,
            top: particle.position.dy,
            child:
                Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: particle.color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: particle.color, blurRadius: 8),
                        ],
                      ),
                    )
                    .animate()
                    .fadeOut(duration: 800.ms)
                    .moveY(begin: 0, end: particle.velocity.dy * 50)
                    .moveX(begin: 0, end: particle.velocity.dx * 50),
          ),
        ),

        // Bugs
        ...List.generate(_bugs.length, (index) {
          final bug = _bugs[index];
          return Positioned(
            left: bug.position.dx * (MediaQuery.of(context).size.width * 0.5),
            top: bug.position.dy * 450,
            child: GestureDetector(
              onTap: () {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final position = box.localToGlobal(
                  Offset(
                    bug.position.dx * (MediaQuery.of(context).size.width * 0.5),
                    bug.position.dy * 450,
                  ),
                );
                _smashBug(index, position);
              },
              child:
                  Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [Colors.red.shade400, Colors.red.shade900],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.5),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.bug_report,
                          color: Colors.white,
                          size: 24,
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shake(duration: 500.ms, hz: 2)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.1, 1.1),
                      ),
            ),
          );
        }),
      ],
    );
  }
}

class Bug {
  final Offset position;
  final double speed;

  Bug({required this.position, required this.speed});
}

class Particle {
  final Offset position;
  final Offset velocity;
  final Color color;

  Particle({
    required this.position,
    required this.velocity,
    required this.color,
  });
}
