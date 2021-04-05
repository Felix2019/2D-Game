import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Background extends PositionComponent {
  Rect _rect;
  Paint _paint;
  Color _gradientTop = Colors.redAccent;

  Background() {
    print(width);
    _rect = Rect.fromLTWH(0, 0, width, height);

    _paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, height),
        [
          _gradientTop,
          Colors.greenAccent,
        ],
      );
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(size.toRect(), _paint);
    // canvas.drawRect(_rect, _paint);
  }

  @override
  void update(double t) {
    // Timer(Duration(seconds: 2), () => {gradientTop = Colors.orange});
  }
}

//   void update(double t) {
//     // if (isDead) {
//     //   flyRect = flyRect.translate(0, game.tilescreenSize * 12 * t);
//     //   if (flyRect.top > game.screenscreenSize.height) {
//     //     isOffScreen = true;
//     //   }
//     // }
//     if (move) {
//       var movement = game.tilescreenSize * 6 * t;
//       flyRect = flyRect.translate(movement, 0);
//       move = false;
//     }

//     // if (jump) {
//     //   flyRect = flyRect.translate(0, -game.tilescreenSize * 12 * t);
//     //   if (flyRect.top < (game.screenscreenSize.height / 4)) {
//     //     print("lol" + (game.screenscreenSize.height / 4).toString());
//     //     jump = false;
//     //     flyRect = flyRect.translate(0, (game.screenscreenSize.height / 1.25) + 120);
//     //   }
//     //   // print(game.screenscreenSize.height);

//     // }
//   }
