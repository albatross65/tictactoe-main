import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

class BubbleScreen extends StatefulWidget {
  const BubbleScreen({super.key});

  @override
  State<BubbleScreen> createState() => _BubbleScreenState();
}

class _BubbleScreenState extends State<BubbleScreen> {
  late final SoundManager soundManager;

  @override
  void initState() {
    soundManager = SoundManager();
    super.initState();
  }

  @override
  void dispose() {
    soundManager.disposeBackgroundSound();
    super.dispose();
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CHOOSE YOUR GAME',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                // First Neumorphic Button
                buildNeumorphicButton(
                  'Tic Tac Toe\nWith Super Bubbles',
                  Color(0xff06beb6),
                      () {
                    gameModel.setSuperBubblesMode(true);
                    Navigator.pushNamed(context, '/mode');
                  },
                ),
                // Second Neumorphic Button
                buildNeumorphicButton(
                  'Tic Tac Toe\nWithout Super Bubbles',
                  Color(0xffef629f),
                      () {
                    gameModel.setSuperBubblesMode(false);
                    Navigator.pushNamed(context, '/mode');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
