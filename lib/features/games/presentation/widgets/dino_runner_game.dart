import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import 'dart:math';

class DinoRunnerGame extends StatefulWidget {
  const DinoRunnerGame({super.key});

  @override
  State<DinoRunnerGame> createState() => _DinoRunnerGameState();
}

class _DinoRunnerGameState extends State<DinoRunnerGame>
    with TickerProviderStateMixin {
  // Game state
  bool _isGameRunning = false;
  bool _isGameOver = false;
  int _score = 0;
  int _highScore = 0;
  double _difficultyMultiplier = 1.0;

  // Player state
  double _playerY = 0;
  double _playerVelocity = 0;
  bool _isJumping = false;

  // Visual Effects
  double _shakeOffset = 0;

  // Game physics
  final double _gravity = 1.2;
  final double _jumpPower = -18;
  final double _groundLevel = 0;

  // Entities
  List<Obstacle> _obstacles = [];
  List<Particle> _particles = [];

  // Loops
  late Ticker _ticker;
  Timer? _obstacleSpawner;
  double _gameSpeed = 6;
  double _gridOffset = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
    _ticker = createTicker(_onTick);
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _highScore = prefs.getInt('cyberpunk_runner_highscore') ?? 0;
    });
  }

  Future<void> _saveHighScore() async {
    if (_score > _highScore) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('cyberpunk_runner_highscore', _score);
      setState(() {
        _highScore = _score;
      });
    }
  }

  void _startGame() {
    setState(() {
      _isGameRunning = true;
      _isGameOver = false;
      _score = 0;
      _playerY = _groundLevel;
      _playerVelocity = 0;
      _obstacles.clear();
      _particles.clear();
      _gameSpeed = 7;
      _difficultyMultiplier = 1.0;
      _shakeOffset = 0;
    });

    _ticker.start();

    _obstacleSpawner?.cancel();
    _obstacleSpawner = Timer.periodic(const Duration(milliseconds: 1200), (
      timer,
    ) {
      _spawnObstacle();
    });
  }

  void _onTick(Duration elapsed) {
    if (!_isGameRunning || _isGameOver) return;

    // Calculate delta time in seconds (capped to prevent huge jumps on lag)
    // For simplicity in this style of game, we can mostly assume fixed step or just run updates per frame.
    // However, to be "smooth" regardless of frame rate, using delta time is best.
    // For now, let's keep logic simple: 1 tick = 1 update frame.
    // Ticker runs at screen refresh rate (60hz or 120hz).
    // We'll normalize to roughly 60fps target speed.

    _updateGame();
  }

  void _updateGame() {
    setState(() {
      // 1. Difficulty Scaling
      _difficultyMultiplier += 0.0003; // Slightly slower ramp up for fairness
      _gameSpeed = 7 * _difficultyMultiplier;

      // 2. Physics & Player
      if (_isJumping || _playerY < _groundLevel) {
        _playerVelocity += _gravity;
        _playerY += _playerVelocity;

        if (_playerY >= _groundLevel) {
          _playerY = _groundLevel;
          _playerVelocity = 0;
          _isJumping = false;
          _spawnLandingParticles();
        }
      }

      // Background Grid Scroll
      _gridOffset -= _gameSpeed * 0.5;
      if (_gridOffset <= -40) _gridOffset = 0;

      // 3. Update Entities
      // Obstacles
      for (var obstacle in _obstacles) {
        obstacle.x -= _gameSpeed;
      }
      _obstacles.removeWhere((obstacle) {
        if (obstacle.x < -100) {
          _score += 10;
          return true;
        }
        return false;
      });

      // Particles
      for (var particle in _particles) {
        particle.update();
      }
      _particles.removeWhere((p) => p.life <= 0);

      // Trail Particles (Run Effect)
      if (_playerY == _groundLevel && _score % 5 == 0) {
        _particles.add(
          Particle(
            x: 100,
            y: 50, // Foot level
            color: Colors.cyanAccent.withValues(alpha: 0.5),
            vx: -_gameSpeed * 0.8,
            vy: (Random().nextDouble() - 0.5) * 2,
            size: 3,
          ),
        );
      }

      // 4. Collision
      // Player hitbox (somewhat smaller than visual for forgiveness)
      Rect playerRect = Rect.fromLTWH(
        100 + 15,
        200 - 50 - _playerY + 10,
        10,
        30,
      );

      for (var obstacle in _obstacles) {
        // Adjust hitbox based on obstacle type
        // Flying drones are higher up
        double obstacleBottom = obstacle.isFlying
            ? 200 - obstacle.height - 40
            : 200 - obstacle.height;
        Rect obstacleRect = Rect.fromLTWH(
          obstacle.x + 5,
          obstacleBottom + 5,
          30,
          obstacle.height - 10,
        );

        if (playerRect.overlaps(obstacleRect)) {
          _gameOver();
          return;
        }
      }
    });
  }

  void _spawnObstacle() {
    if (!_isGameRunning || _isGameOver) return;

    // Spawn rate decreases as difficulty increases (harder = more obstacles)
    int spawnRate = max(500, (1400 - (_difficultyMultiplier * 600)).round());
    _obstacleSpawner?.cancel();
    _obstacleSpawner = Timer.periodic(
      Duration(milliseconds: spawnRate),
      (timer) => _spawnObstacle(),
    );

    final random = Random();
    int type = random.nextInt(4); // 0, 1, 2, 3

    // Introduce flying obstacles only after some score/difficulty
    bool isFlying = false;
    if (_score > 300 && random.nextBool()) {
      isFlying = true;
      type = 3; // Drone type
    }

    setState(() {
      _obstacles.add(
        Obstacle(
          x: 900,
          type: type,
          height: isFlying
              ? 30.0
              : (type == 1 ? 50.0 : 40.0 + random.nextInt(20)),
          width: isFlying ? 40 : 40,
          isFlying: isFlying,
        ),
      );
    });
  }

  // ... (Particles and Jump methods remain same)

  void _spawnLandingParticles() {
    for (int i = 0; i < 10; i++) {
      _particles.add(
        Particle(
          x: 110 + (Random().nextDouble() * 20),
          y: 0,
          color: Colors.white,
          vx: (Random().nextDouble() - 0.5) * 10,
          vy: -Random().nextDouble() * 5,
          size: 4,
        ),
      );
    }
  }

  void _jump() {
    if (!_isGameRunning) {
      _startGame();
      return;
    }

    if (_isGameOver) {
      _startGame();
      return;
    }

    if (!_isJumping && _playerY == _groundLevel) {
      setState(() {
        _isJumping = true;
        _playerVelocity = _jumpPower;

        for (int i = 0; i < 5; i++) {
          _particles.add(
            Particle(
              x: 120,
              y: 10,
              color: Colors.cyanAccent,
              vx: -_gameSpeed,
              vy: 2 + Random().nextDouble() * 2,
              size: 3,
            ),
          );
        }
      });
    }
  }

  // ... (GameOver and Dispose remain same)

  void _gameOver() {
    _saveHighScore();
    setState(() {
      _isGameOver = true;
      _isGameRunning = false;
      _shakeOffset = 10;
    });

    _ticker.stop();
    _obstacleSpawner?.cancel();

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted || _shakeOffset <= 0) {
        timer.cancel();
        setState(() => _shakeOffset = 0);
      } else {
        setState(() => _shakeOffset = -_shakeOffset * 0.8);
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _obstacleSpawner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          // ... (Key handling)
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.space) {
            _jump();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: GestureDetector(
          onTap: _jump,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F1A),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.3),
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // ... (Background Grid - OptimizedGridPainter)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: OptimizedGridPainter(offset: _gridOffset),
                    ),
                  ),

                  // 2. Game World with Shake
                  Transform.translate(
                    offset: Offset(_shakeOffset, 0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            // Ground
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.cyanAccent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyanAccent,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Particles
                            ..._particles.map(
                              (p) => Positioned(
                                left: p.x,
                                bottom:
                                    100 + p.y + (constraints.maxHeight * 0.2),
                                child: Container(
                                  width: p.size,
                                  height: p.size,
                                  decoration: BoxDecoration(
                                    color: p.color.withValues(alpha: p.life),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),

                            // Player
                            Positioned(
                              left: 100,
                              bottom:
                                  100 +
                                  _playerY +
                                  (constraints.maxHeight * 0.2),
                              child: _buildPlayer(),
                            ),

                            // Obstacles
                            ..._obstacles.map((obstacle) {
                              // Dynamic positioning for flying obstacles
                              double bottomPos =
                                  100 + (constraints.maxHeight * 0.2);
                              if (obstacle.isFlying) {
                                bottomPos += 40; // Fly above ground
                              }

                              return Positioned(
                                left: obstacle.x,
                                bottom: bottomPos,
                                child: _buildObstacle(obstacle),
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ),

                  // ... (HUD and Game Over Overlay)
                  // Keeping existing HUD code
                  Positioned(
                    top: 24,
                    left: 24,
                    right: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SCORE",
                              style: GoogleFonts.orbitron(
                                color: Colors.cyanAccent,
                                fontSize: 12,
                                letterSpacing: 2,
                              ),
                            ),
                            Text(
                              _score.toString().padLeft(6, '0'),
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "HIGH SCORE",
                              style: GoogleFonts.orbitron(
                                color: Colors.pinkAccent,
                                fontSize: 12,
                                letterSpacing: 2,
                              ),
                            ),
                            Text(
                              _highScore.toString().padLeft(6, '0'),
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Game Over Overlay
                  if (!_isGameRunning || _isGameOver)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.7),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                    _isGameOver
                                        ? "SYSTEM FAILURE"
                                        : "CYBER RUNNER",
                                    style: GoogleFonts.orbitron(
                                      fontSize: _isGameOver ? 42 : 36,
                                      fontWeight: FontWeight.bold,
                                      color: _isGameOver
                                          ? Colors.redAccent
                                          : Colors.cyanAccent,
                                      shadows: [
                                        BoxShadow(
                                          color: _isGameOver
                                              ? Colors.red
                                              : Colors.cyan,
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                  )
                                  .animate(
                                    onPlay: (c) => c.repeat(reverse: true),
                                  )
                                  .scaleXY(end: 1.05, duration: 1.seconds),
                              const SizedBox(height: 20),
                              if (_isGameOver)
                                Text(
                                  "FINAL SCORE: $_score",
                                  style: GoogleFonts.jetBrainsMono(
                                    color: Colors.white70,
                                    fontSize: 18,
                                  ),
                                ),
                              const SizedBox(height: 40),
                              Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color: Colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                    child: Text(
                                      "PRESS SPACE OR TAP",
                                      style: GoogleFonts.orbitron(
                                        color: Colors.white,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                  .animate(onPlay: (c) => c.repeat())
                                  .fadeIn(duration: 500.ms)
                                  .fadeOut(delay: 500.ms),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ... (Player Widget same)
  Widget _buildPlayer() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withValues(alpha: 0.6),
            blurRadius: 15,
          ),
        ],
      ),
      child: Stack(
        children: [
          Transform.rotate(
            angle: -0.1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(width: 4, height: 4, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildObstacle(Obstacle obstacle) {
    // Flying drones get a different look
    if (obstacle.isFlying) {
      return Container(
        width: obstacle.width,
        height: obstacle.height,
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.8),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withValues(alpha: 0.5),
              blurRadius: 15,
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.adb_rounded, size: 20, color: Colors.white),
        ),
      );
    }

    Color color = obstacle.type == 0
        ? Colors.purpleAccent
        : (obstacle.type == 1 ? Colors.pinkAccent : Colors.orangeAccent);

    return Container(
      width: obstacle.width,
      height: obstacle.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 10),
        ],
      ),
      child: Center(
        child: Container(
          width: obstacle.width * 0.6,
          height: obstacle.height * 0.6,
          color: color.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class Obstacle {
  double x;
  final int type;
  final double height;
  final double width;
  final bool isFlying;

  Obstacle({
    required this.x,
    required this.type,
    required this.height,
    required this.width,
    this.isFlying = false,
  });
}

class Particle {
  double x;
  double y;
  final Color color;
  double vx;
  double vy;
  double life = 1.0;
  final double size;

  Particle({
    required this.x,
    required this.y,
    required this.color,
    required this.vx,
    required this.vy,
    required this.size,
  });

  void update() {
    x += vx;
    y += vy;
    vy += 0.5; // Gravity
    life -= 0.05;
  }
}

// Optimized Painter: Reuses paint objects where possible
class OptimizedGridPainter extends CustomPainter {
  final double offset;
  // Cache paint object
  static final Paint _paint = Paint()
    ..color = Colors.cyanAccent.withValues(alpha: 0.1)
    ..strokeWidth = 1.0;

  OptimizedGridPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final double spacing = 40.0;

    // Vertical lines moving
    for (double i = offset % spacing; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, size.height),
        Offset(i + (size.width / 2 - i) * 0.5, size.height * 0.4),
        _paint,
      );
    }

    // Horizontal lines fixed
    for (double i = size.height; i > size.height * 0.4; i -= spacing * 0.5) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), _paint);
    }
  }

  @override
  bool shouldRepaint(OptimizedGridPainter oldDelegate) =>
      oldDelegate.offset != offset;
}
