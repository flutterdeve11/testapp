
import 'package:flutter/material.dart';
import 'dart:math';
class SnackGameScreen extends StatefulWidget {
  @override
  _SnackGameScreenState createState() => _SnackGameScreenState();
}

class _SnackGameScreenState extends State<SnackGameScreen> {
  double characterX = 0;
  double characterY = 0;
  double screenWidth = 0;
  double screenHeight = 0;
  List<Offset> snacks = [];

  void updateCharacterPosition(double newX) {
    setState(() {
      characterX = newX;
    });
  }

  void addSnack() {
    setState(() {
      double x = Random().nextDouble() * screenWidth;
      snacks.add(Offset(x, 0));
    });
  }

  void moveSnacks() {
    setState(() {
      snacks = snacks.map((offset) => offset + Offset(0, 5)).toList();
    });
  }

  void checkCollisions() {
    snacks.removeWhere((offset) =>
    (offset.dx - characterX).abs() < 30 &&
        (offset.dy - characterY).abs() < 30);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Snack Eating Game'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          updateCharacterPosition(characterX + details.delta.dx);
        },
        child: Stack(
          children: [
            Positioned(
              left: characterX,
              top: characterY,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
              ),
            ),
            ...snacks.map((offset) => Positioned(
              left: offset.dx,
              top: offset.dy,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.green,
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addSnack();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Start the game loop
    Future.delayed(Duration(milliseconds: 50), startGameLoop);
  }

  void startGameLoop() {
    moveSnacks();
    checkCollisions();
    startGameLoop();
  }
}
