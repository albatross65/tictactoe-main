import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';

class ModeScreen extends StatefulWidget {
  const ModeScreen({super.key});

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  late final TicTacToeGameModel gameModel;

  @override
  void initState() {
    super.initState();
    gameModel = context.read<TicTacToeGameModel>();
  }

  // Smaller, subtle neumorphic back button
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

  @override
  Widget build(BuildContext context) {
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
                    Navigator.pushNamed(context, '/bubbles');
                  },
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Game Mode Buttons
                    buildNeumorphicButton(
                      'Player vs AI',
                      Color(0xffef629f),
                          () async {
                        gameModel.setPlayerVsAI(true);
                        if (!context.mounted) return;
                        Navigator.pushNamed(context, '/grid');
                      },
                    ),
                    buildNeumorphicButton(
                      'Player vs Player',
                      Color(0xff06beb6),
                          () async {
                        gameModel.setPlayerVsAI(false);
                        if (!context.mounted) return;
                        Navigator.pushNamed(context, '/grid');
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
