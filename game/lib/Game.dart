import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'package:flutter/gestures.dart';
import 'package:game/main.dart';
import 'components/enemy.dart';
import 'components/player.dart';
import 'components/background.dart';

class MyGame extends BaseGame with HasDraggableComponents {
  Size screenSize1;
  double tileSize;
  bool crash;
  Enemy enemy;
  Random rnd;
  List<Enemy> enemies;

  Background background;
  PlayerTest player;

  @override
  Future<void> onLoad() async {
    add(BackgroundTest());
    // add(Square()
    //     // ..x = 50
    //     // ..y = 50,
    //     );
    add(MyCrate());
  }

  MyGame() {
    // initialize();
  }

  // @override
  // void onTapDown(TapDownDetails details) {
  //   print(
  //       "Player tap down on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
  // }

  void initialize() async {
    // joystick.addObserver(player);

    add(background);
    // add(player);

    enemies = <Enemy>[];
    rnd = Random();

    // spawnEnemies();
  }

  void spawnEnemies() {
    enemy = Enemy(this);
    enemies.add(enemy);
    add(enemy);

    // Timer(200, () {
    //   spawnEnemies();
    // });
  }

  @override
  void update(double t) {
    // enemies.forEach((enemy) {
    //   if (enemy.enemyRect != null) {
    //     // if (player.rect.overlaps(enemy.enemyRect)) {
    //     //   crash = true;

    //     //   addWidgetOverlay(
    //     //       "PauseMenu", // Your overlay identifier
    //     //       Positioned(
    //     //         top: 50,
    //     //         right: 50,
    //     //         child: Container(
    //     //           width: 300,
    //     //           height: 100,
    //     //           color: Colors.white,
    //     //         ),
    //     //       ));
    //     // }
    //   }
    // });

    super.update(t);
  }
}
