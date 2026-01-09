import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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

  // Player state
  double _playerY = 0;
  double _playerVelocity = 0;
  bool _isJumping = false;

  // Game physics
  final double _gravity = 0.8;
  final double _jumpPower = -15;
  final double _groundLevel = 0;

  // Obstacles
  List<Obstacle> _obstacles = [];
  Timer? _gameLoop;
  Timer? _obstacleSpawner;
  double _gameSpeed = 5;

  @override
  void initState() {
    super.initState();
  }

  void _startGame() {
    setState(() {
      _isGameRunning = true;
      _isGameOver = false;
      _score = 0;
      _playerY = _groundLevel;
      _playerVelocity = 0;
      _obstacles.clear();
      _gameSpeed = 5;
    });

    // Game loop - 60 FPS
    _gameLoop = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _updateGame();
    });

    // Spawn obstacles
    _obstacleSpawner = Timer.periodic(const Duration(milliseconds: 1500), (
      timer,
    ) {
      _spawnObstacle();
    });
  }

  void _updateGame() {
    if (!_isGameRunning || _isGameOver) return;

    setState(() {
      // Update player physics
      if (_isJumping || _playerY < _groundLevel) {
        _playerVelocity += _gravity;
        _playerY += _playerVelocity;

        if (_playerY >= _groundLevel) {
          _playerY = _groundLevel;
          _playerVelocity = 0;
          _isJumping = false;
        }
      }

      // Update obstacles
      for (var obstacle in _obstacles) {
        obstacle.x -= _gameSpeed;
      }

      // Remove off-screen obstacles and increase score
      _obstacles.removeWhere((obstacle) {
        if (obstacle.x < -100) {
          _score += 10;
          return true;
        }
        return false;
      });

      // Check collisions
      for (var obstacle in _obstacles) {
        if (_checkCollision(obstacle)) {
          _gameOver();
          return;
        }
      }

      // Increase difficulty
      if (_score % 100 == 0 && _score > 0) {
        _gameSpeed = min(_gameSpeed + 0.5, 12);
      }
    });
  }

  void _spawnObstacle() {
    if (!_isGameRunning || _isGameOver) return;

    final random = Random();
    final type = random.nextInt(3); // 0: cactus, 1: bird, 2: double cactus

    setState(() {
      _obstacles.add(
        Obstacle(x: 800, type: type, height: type == 1 ? 40.0 : 50.0),
      );
    });
  }

  bool _checkCollision(Obstacle obstacle) {
    const playerX = 100.0;
    const playerWidth = 40.0;
    const playerHeight = 50.0;

    final playerBottom = _playerY + playerHeight;
    final obstacleLeft = obstacle.x;
    final obstacleRight = obstacle.x + 40;
    final obstacleTop = obstacle.type == 1 ? -80.0 : 0.0; // Bird flies higher

    // Simple box collision
    if (playerX + playerWidth > obstacleLeft &&
        playerX < obstacleRight &&
        playerBottom > obstacleTop) {
      return true;
    }

    return false;
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
      });
    }
  }

  void _gameOver() {
    setState(() {
      _isGameOver = true;
      _isGameRunning = false;
      if (_score > _highScore) {
        _highScore = _score;
      }
    });

    _gameLoop?.cancel();
    _obstacleSpawner?.cancel();
  }

  @override
  void dispose() {
    _gameLoop?.cancel();
    _obstacleSpawner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
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
          color: Colors.transparent,
          child: Stack(
            children: [
              // Score
              Positioned(
                top: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "HI: ${_highScore.toString().padLeft(5, '0')}",
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _score.toString().padLeft(5, '0'),
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Game area
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final groundY = constraints.maxHeight * 0.7;

                    return Stack(
                      children: [
                        // Ground line
                        Positioned(
                          bottom: constraints.maxHeight * 0.3,
                          left: 0,
                          right: 0,
                          child: Container(height: 2, color: Colors.white30),
                        ),

                        // Player (Flutter logo as dino)
                        Positioned(
                          left: 100,
                          bottom: constraints.maxHeight * 0.3 - _playerY,
                          child: _buildPlayer(),
                        ),

                        // Obstacles
                        ..._obstacles.map((obstacle) {
                          return Positioned(
                            left: obstacle.x,
                            bottom: obstacle.type == 1
                                ? constraints.maxHeight * 0.3 + 80
                                : constraints.maxHeight * 0.3,
                            child: _buildObstacle(obstacle),
                          );
                        }),

                        // Start/Game Over screen
                        if (!_isGameRunning || _isGameOver)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black54,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _isGameOver
                                          ? Icons.error_outline
                                          : Icons.play_circle_outline,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      _isGameOver
                                          ? "GAME OVER!"
                                          : "FLUTTER RUNNER",
                                      style: GoogleFonts.outfit(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    if (_isGameOver)
                                      Text(
                                        "Score: $_score",
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 24,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    const SizedBox(height: 30),
                                    Text(
                                      "Tap or SPACE to ${_isGameOver ? 'Restart' : 'Start'}",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),

              // Instructions
              if (_isGameRunning && !_isGameOver)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Text(
                    "🎮 Tap or SPACE to Jump",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF02569B), // Flutter blue
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF02569B).withOpacity(0.5),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Icon(Icons.flutter_dash, color: Colors.white, size: 30),
    );
  }

  Widget _buildObstacle(Obstacle obstacle) {
    IconData icon;
    Color color;

    switch (obstacle.type) {
      case 0: // Cactus (bug)
        icon = Icons.bug_report;
        color = Colors.red;
        break;
      case 1: // Bird (cloud)
        icon = Icons.cloud;
        color = Colors.grey;
        break;
      case 2: // Double cactus (warning)
        icon = Icons.warning;
        color = Colors.orange;
        break;
      default:
        icon = Icons.bug_report;
        color = Colors.red;
    }

    return Container(
      width: 40,
      height: obstacle.height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8)],
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}

class Obstacle {
  double x;
  final int type;
  final double height;

  Obstacle({required this.x, required this.type, required this.height});
}
