
import 'package:flutter/material.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double ballX = 0;
  double ballY = 0;
  double screenWidth = 0;
  double screenHeight = 0;
  int score = 0;

  void updatePosition() {
    setState(() {
      ballX = Random().nextDouble() * screenWidth;
      ballY = Random().nextDouble() * screenHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tap the Ball Game'),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: ballX,
              top: ballY,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    score++;
                    updatePosition();
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              'Score: $score',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            score = 0;
            updatePosition();
          });
        },
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}