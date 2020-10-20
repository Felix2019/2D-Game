import 'package:flame/flame.dart';

import 'Game.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  final size = await Flame.util.initialDimensions();
  final game = MyGame(size);
  runApp(game.widget);
  MaterialApp(
    title: 'Shadow Training',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(),
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: game.widget,
          ),

          // Positioned(
          //   bottom: 0,
          //   child: SizedBox(
          //     height: 50,
          //     child: RaisedButton(
          //       onPressed: () => print("sal"),
          //       child: const Text('Enabled Button',
          //           style: TextStyle(fontSize: 20)),
          //     ),
          //   ),
          // ),
        ],
      ),
    ),
  );

  // Util flameUtil = Util();
  // flameUtil.fullScreen();
  // flameUtil.setOrientation(DeviceOrientation.portraitUp);
}
