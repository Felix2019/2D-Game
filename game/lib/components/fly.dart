// import 'dart:ui';
// import 'package:flutter/material.dart';
// import '../Game.dart';

// class Fly {
//   final MyGame game;
//   Rect flyRect;
//   Paint flyPaint;
//   bool isDead = false;
//   bool isOffScreen = false;

//   Fly(this.game, double x, double y) {
//     flyRect = Rect.fromLTWH(x, y, game.tilescreenSize, game.tilescreenSize);
//     flyPaint = Paint();
//     flyPaint.color = Color(0xff6ab04c);
//   }

//   void render(Canvas c) {
//     c.drawRect(flyRect, flyPaint);
//   }

//   void update(double t) {
//     if (isDead) {
//       flyRect = flyRect.translate(0, game.tilescreenSize * 12 * t);
//       if (flyRect.top > game.screenscreenSize.height) {
//         isOffScreen = true;
//       }
//     }
//   }

//   void onTapDown() {
//     isDead = true;
//     flyPaint.color = Color(0xffff4757);
//     // game.spawnFly();
//   }
// }
