import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../Game.dart';

class Enemy extends PositionComponent with HasGameRef<MyGame> {
  Rect enemyRect;
  Paint enemyPaint;
  double x;
  double y;
  Random rnd = Random();
  double moveX = 0;
  double moveY = 0;
  final MyGame game;

  Offset targetLocation;

  Enemy(this.game) {
    enemyRect = Rect.fromLTWH(
        (width / 2) - game.tileSize, 0, game.tileSize, game.tileSize);
    enemyPaint = Paint();
    enemyPaint.color = Colors.green;
    setTargetLocation();
  }

  @override
  void render(Canvas canvas) {
    if (enemyRect != null) {
      canvas.drawRect(enemyRect, enemyPaint);
    }
  }

  @override
  void update(double t) {
    if (targetLocation != null) {
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(enemyRect.left, enemyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        enemyRect = enemyRect.shift(stepToTarget);
      } else {
        enemyRect = enemyRect.shift(toTarget);
        setTargetLocation();
      }
    }

    super.update(t);
  }

  double get speed => game.tileSize * 3;

  void setTargetLocation() {
    moveX = rnd.nextDouble() * (width - (game.tileSize * 2.025));
    moveY = rnd.nextDouble() * (height - (game.tileSize * 2.025));

    targetLocation = Offset(moveX, moveY);
  }
}
