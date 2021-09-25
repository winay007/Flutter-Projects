import 'dart:async';

import 'package:flap_bird_game/widgets/barrier.dart';
import 'package:flap_bird_game/widgets/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdaYaxis = 0;
  double height = 0;
  double initialHeight = birdaYaxis;
  double time = 0;
  bool gameStarted = false;
  static double barrierXone = 0;
  double barrierXtwo = barrierXone + 2;

  void _jump() {
    setState(() {
      time = 0;
      initialHeight = birdaYaxis;
    });
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 40), (timer) {
      time += 0.05;
      height = (-4.9) * time * time + 2.8 * time;
      setState(() {
        birdaYaxis = initialHeight - height;
       
      });

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (birdaYaxis > 1) {
        timer.cancel();
        gameStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          _jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(children: [
                AnimatedContainer(
                  alignment: Alignment(0, birdaYaxis),
                  duration: Duration(milliseconds: 0),
                  child: MyBird(),
                  color: Colors.blue,
                ),
                if (!gameStarted)
                  Container(
                    alignment: Alignment(0, -0.2),
                    child: Text(
                      'T A P   T O   P L A Y',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(200.0)),
                AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.05),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(210.0)),
                AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(250.0)),
                AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(150.0)),
              ]),
            ),
            Container(
              height: 15,
              width: double.infinity,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Score',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('0',
                            style:
                                TextStyle(fontSize: 17, color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Best Score',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '10',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
