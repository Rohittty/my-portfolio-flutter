import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ServerBalancerGame extends StatefulWidget {
  const ServerBalancerGame({super.key});

  @override
  State<ServerBalancerGame> createState() => _ServerBalancerGameState();
}

class _ServerBalancerGameState extends State<ServerBalancerGame> {
  double _load = 0.5;
  double _capacity = 0.5;
  bool _isStable = true;
  int _score = 0;
  int _stableTime = 0;
  Timer? _loadFluctuation;
  Timer? _scoreTimer;
  List<ServerParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    _startSimulation();
    _startScoring();
  }

  void _startSimulation() {
    _loadFluctuation = Timer.periodic(const Duration(milliseconds: 100), (
      timer,
    ) {
      if (!mounted) return;
      setState(() {
        // Random load fluctuation
        _load += (Random().nextDouble() - 0.5) * 0.02;
        _load = _load.clamp(0.0, 1.0);

        // Stability check
        double ratio = _load / _capacity.clamp(0.1, 1.0);
        bool wasStable = _isStable;
        _isStable = ratio > 0.4 && ratio < 0.9;

        // Create particles on state change
        if (wasStable != _isStable) {
          for (int i = 0; i < 5; i++) {
            _particles.add(
              ServerParticle(
                position: Offset(Random().nextDouble(), 0.5),
                color: _isStable ? Colors.greenAccent : Colors.redAccent,
              ),
            );
          }
          Future.delayed(const Duration(milliseconds: 600), () {
            if (mounted) setState(() => _particles.clear());
          });
        }
      });
    });
  }

  void _startScoring() {
    _scoreTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_isStable) {
        setState(() {
          _stableTime++;
          _score += 10;
        });
      }
    });
  }

  @override
  void dispose() {
    _loadFluctuation?.cancel();
    _scoreTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Status & Score
          Column(
            children: [
              Text(
                    _isStable ? "⚡ SYSTEM STABLE" : "⚠️ WARNING: UNSTABLE",
                    style: GoogleFonts.jetBrainsMono(
                      color: _isStable ? Colors.greenAccent : Colors.redAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: _isStable
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  )
                  .animate(key: ValueKey(_isStable))
                  .fadeIn()
                  .scale(begin: const Offset(0.8, 0.8)),
              const SizedBox(height: 8),
              Text(
                "SCORE: $_score | UPTIME: ${_stableTime}s",
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),

          // Server Rack Visualization
          Stack(
            alignment: Alignment.center,
            children: [
              // Particles
              ..._particles.map(
                (p) => Positioned(
                  left: p.position.dx * 200,
                  top: p.position.dy * 200,
                  child:
                      Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: p.color,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: p.color, blurRadius: 8),
                              ],
                            ),
                          )
                          .animate()
                          .fadeOut(duration: 600.ms)
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(2, 2),
                          ),
                ),
              ),

              // Server Rack
              Container(
                height: 250,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: _isStable ? AppTheme.neonAccent : Colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: (_isStable ? AppTheme.neonAccent : Colors.red)
                          .withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Server Slots
                    ...List.generate(5, (i) {
                      bool isActive = (i / 5) < _load;
                      return Expanded(
                        child:
                            Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: isActive
                                          ? [
                                              _isStable
                                                  ? Colors.green
                                                  : Colors.red,
                                              _isStable
                                                  ? Colors.greenAccent
                                                  : Colors.redAccent,
                                            ]
                                          : [
                                              Colors.grey.shade800,
                                              Colors.grey.shade900,
                                            ],
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: isActive
                                        ? [
                                            BoxShadow(
                                              color: _isStable
                                                  ? Colors.greenAccent
                                                  : Colors.redAccent,
                                              blurRadius: 8,
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.dns,
                                      color: isActive
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                      size: 20,
                                    ),
                                  ),
                                )
                                .animate(
                                  onPlay: (controller) =>
                                      isActive ? controller.repeat() : null,
                                )
                                .shimmer(
                                  duration: 2000.ms,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                      );
                    }),
                  ],
                ),
              ),

              // Load Indicator
              Positioned(
                left: -40,
                child: Column(
                  children: [
                    Text(
                      "LOAD",
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "${(_load * 100).toInt()}%",
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 48),

          // Capacity Control
          Column(
            children: [
              Text(
                "⚙️ SERVER CAPACITY CONTROL",
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white70,
                  fontSize: 12,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "0%",
                    style: GoogleFonts.jetBrainsMono(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _capacity,
                      onChanged: (v) => setState(() => _capacity = v),
                      activeColor: AppTheme.neonAccent,
                      inactiveColor: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    "100%",
                    style: GoogleFonts.jetBrainsMono(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text(
                "Current: ${(_capacity * 100).toInt()}%",
                style: GoogleFonts.jetBrainsMono(
                  color: AppTheme.neonAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServerParticle {
  final Offset position;
  final Color color;

  ServerParticle({required this.position, required this.color});
}
