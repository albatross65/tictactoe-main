import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';

List<String> levels = [
  'easy',
  'medium',
  'hard',
];

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  Widget buildNeumorphicButton(String text, Color color, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: 280,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              offset: Offset(-4, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNeumorphicIconButton(IconData icon, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xff06beb6),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              offset: Offset(-4, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff20002c),
              Color(0xffcbb4d4),
              Color(0xff20002c),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Back button in the top-left corner
              Positioned(
                top: 20,
                left: 20,
                child: buildNeumorphicIconButton(
                  Icons.arrow_back,
                      () {
                    Navigator.pop(context); // Navigate back on pressing
                  },
                ),
              ),
              // Main content with the level buttons
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var level in levels)
                      buildNeumorphicButton(
                        level.toUpperCase(),
                        Color(0xffef629f),
                            () {
                          gameModel.setLevelDifficulty(level); // Set difficulty
                          Navigator.pushNamed(context, '/game'); // Navigate to game
                        },
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
