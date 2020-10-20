import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class Background extends Component {
  final bluePaint = Paint()..color = const Color(0xFF0000FF);
  Paint paint;
  Rect backgroundRect;
  Paint backgroundPaint;
  Size screenSize;

  Background() {
    backgroundPaint = Paint();
    backgroundPaint.color = Colors.red;
  }

  @override
  void render(Canvas canvas) {
    if (backgroundRect != null) {
      canvas.drawRect(backgroundRect, backgroundPaint);
    }
  }

  @override
  void update(double dt) {}

  @override
  void resize(Size size) {
    backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    super.resize(size);
  }
}

//   void update(double t) {
//     // if (isDead) {
//     //   flyRect = flyRect.translate(0, game.tileSize * 12 * t);
//     //   if (flyRect.top > game.screenSize.height) {
//     //     isOffScreen = true;
//     //   }
//     // }
//     if (move) {
//       var movement = game.tileSize * 6 * t;
//       flyRect = flyRect.translate(movement, 0);
//       move = false;
//     }

//     // if (jump) {
//     //   flyRect = flyRect.translate(0, -game.tileSize * 12 * t);
//     //   if (flyRect.top < (game.screenSize.height / 4)) {
//     //     print("lol" + (game.screenSize.height / 4).toString());
//     //     jump = false;
//     //     flyRect = flyRect.translate(0, (game.screenSize.height / 1.25) + 120);
//     //   }
//     //   // print(game.screenSize.height);

//     // }
//   }
