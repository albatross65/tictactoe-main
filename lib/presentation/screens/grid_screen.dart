import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/data/providers/ad_settings.dart';
import 'package:tictactoe/data/providers/gameplay.dart';
import 'package:tictactoe/domain/config/game_repo.dart';

List<String> gridSizes = [
  '3x3',
  '6x6',
  '9x9',
  '11x11',
  '15x15',
];

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  // Updated Button Design with gradient and shadows
  Widget buildGradientButton(String text, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: 280,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Color(0xff06beb6),  // Gradient colors for more vivid effect
              Color(0xff48b1bf),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              blurRadius: 9,
              offset: Offset(-4, -4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    final gameplay = context.watch<Gameplay>();
    final adModel = context.watch<AdSettings>();

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
                    Navigator.pushNamed(context, '/mode');
                  },
                ),
              ),
              // Main content: grid size selection buttons
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Select Grid Size',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    for (var gridSize in gridSizes)
                      buildGradientButton(
                        gridSize,
                            () {
                          gameModel.isPlayerVsAI
                              ? Navigator.pushNamed(context, '/level')
                              : Navigator.pushNamed(context, '/game');
                          // Set the grid size to the selected grid size
                          gameModel.setBoardSize(
                            GameRepo().gameConfigurations[gridSize]
                            ?['grid_size'] ??
                                3,
                            gridSize,
                          );
                          gameplay.setGridSize(
                            GameRepo().gameConfigurations[gridSize]
                            ?['grid_size'] ??
                                3,
                          );

                          adModel.setImagePath(gridSize);
                          debugPrint('Grid size: $gridSize');
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
