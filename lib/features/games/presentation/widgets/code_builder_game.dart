import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math';

class CodeBuilderGame extends StatefulWidget {
  const CodeBuilderGame({super.key});

  @override
  State<CodeBuilderGame> createState() => _CodeBuilderGameState();
}

class _CodeBuilderGameState extends State<CodeBuilderGame> {
  // Game state
  bool _isGameRunning = false;
  bool _isGameOver = false;
  int _score = 0;
  int _highScore = 0;
  int _lives = 3;

  // Player state
  double _playerX = 0.5; // Center position (0 to 1)

  // Code snippets falling
  List<CodeSnippet> _codeSnippets = [];
  Timer? _gameLoop;
  Timer? _snippetSpawner;
  double _fallSpeed = 2;

  // Code snippet types
  final List<String> _snippetTypes = [
    'Widget',
    'State',
    'Build',
    'setState',
    'async',
    'await',
    'Future',
    'Stream',
  ];

  final List<Color> _snippetColors = [
    const Color(0xFF2962FF), // Flutter Blue
    const Color(0xFF00E5FF), // DevOps Teal
    const Color(0xFF00FF9D), // Neon Accent
    Colors.purpleAccent,
    Colors.orangeAccent,
  ];

  @override
  void initState() {
    super.initState();
  }

  void _startGame() {
    setState(() {
      _isGameRunning = true;
      _isGameOver = false;
      _score = 0;
      _lives = 3;
      _playerX = 0.5;
      _codeSnippets.clear();
      _fallSpeed = 2;
    });

    // Game loop - 60 FPS
    _gameLoop = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _updateGame();
    });

    // Spawn code snippets
    _snippetSpawner = Timer.periodic(const Duration(milliseconds: 800), (
      timer,
    ) {
      _spawnSnippet();
    });
  }

  void _updateGame() {
    if (!_isGameRunning || _isGameOver) return;

    setState(() {
      // Update code snippets
      for (var snippet in _codeSnippets) {
        snippet.y += _fallSpeed;
      }

      // Check if snippets reached the basket
      _codeSnippets.removeWhere((snippet) {
        if (snippet.y > 0.85) {
          // Check if caught
          if ((snippet.x - _playerX).abs() < 0.08) {
            _score += 10;
            return true;
          } else {
            // Missed - lose a life
            _lives--;
            if (_lives <= 0) {
              _gameOver();
            }
            return true;
          }
        }
        return false;
      });

      // Increase difficulty
      if (_score % 100 == 0 && _score > 0) {
        _fallSpeed = min(_fallSpeed + 0.3, 8);
      }
    });
  }

  void _spawnSnippet() {
    if (!_isGameRunning || _isGameOver) return;

    final random = Random();
    setState(() {
      _codeSnippets.add(
        CodeSnippet(
          x: random.nextDouble() * 0.8 + 0.1,
          y: -0.1,
          code: _snippetTypes[random.nextInt(_snippetTypes.length)],
          color: _snippetColors[random.nextInt(_snippetColors.length)],
        ),
      );
    });
  }

  void _movePlayer(double delta) {
    if (!_isGameRunning || _isGameOver) return;

    setState(() {
      _playerX = (_playerX + delta).clamp(0.1, 0.9);
    });
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
    _snippetSpawner?.cancel();
  }

  @override
  void dispose() {
    _gameLoop?.cancel();
    _snippetSpawner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _movePlayer(-0.05);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _movePlayer(0.05);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.space &&
              !_isGameRunning) {
            _startGame();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (_isGameRunning && !_isGameOver) {
            _movePlayer(details.delta.dx / MediaQuery.of(context).size.width);
          }
        },
        onTap: () {
          if (!_isGameRunning) {
            _startGame();
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              // Score & Lives
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SCORE: $_score",
                          style: GoogleFonts.jetBrainsMono(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "HI: $_highScore",
                          style: GoogleFonts.jetBrainsMono(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: List.generate(_lives, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 24,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              // Game area
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        // Falling code snippets
                        ..._codeSnippets.map((snippet) {
                          return Positioned(
                            left: snippet.x * constraints.maxWidth - 40,
                            top: snippet.y * constraints.maxHeight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: snippet.color.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: snippet.color.withOpacity(0.5),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Text(
                                snippet.code,
                                style: GoogleFonts.firaCode(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),

                        // Player basket
                        Positioned(
                          left: _playerX * constraints.maxWidth - 50,
                          bottom: 50,
                          child: Column(
                            children: [
                              Icon(
                                Icons.shopping_basket,
                                size: 60,
                                color: const Color(0xFF00FF9D),
                              ),
                              Container(
                                width: 100,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF00FF9D,
                                  ).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

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
                            _isGameOver ? Icons.code_off : Icons.code,
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _isGameOver ? "BUILD FAILED!" : "CODE BUILDER",
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
                            "Catch code snippets!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 10),
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

              // Instructions
              if (_isGameRunning && !_isGameOver)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Text(
                    "🎮 Drag or Arrow Keys to Move | Catch Code Snippets!",
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
}

class CodeSnippet {
  double x;
  double y;
  final String code;
  final Color color;

  CodeSnippet({
    required this.x,
    required this.y,
    required this.code,
    required this.color,
  });
}
