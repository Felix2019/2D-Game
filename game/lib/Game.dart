import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/components/joystick/joystick_action.dart';
import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/components/joystick/joystick_directional.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'components/enemy.dart';
import 'components/player.dart';
import 'components/background.dart';

class MyGame extends BaseGame with MultiTouchDragDetector, HasWidgetsOverlay {
  Size screenSize;
  double tileSize;
  bool crash;
  Enemy enemy;
  Random rnd;
  List<Enemy> enemies;
  final size;

  final Background background = Background();
  final Player player = Player();

  final joystick = JoystickComponent(
    directional: JoystickDirectional(
      // spriteBackgroundDirectional: Sprite('directional_background.png'), // optional
      // spriteKnobDirectional: Sprite('directional_knob.png'), // optional
      isFixed: false, // optional
      margin: const EdgeInsets.only(left: 100, bottom: 100), // optional
      size: 80, // optional
      color: Colors.blueGrey, // optional
      opacityBackground: 0.5, // optional
      opacityKnob: 0.8, // optional
    ),

    // actions: [
    //   JoystickAction(
    //     actionId: 1,
    //     size: 50,
    //     margin: const EdgeInsets.all(50),
    //     color: const Color(0xFF0000FF),
    //   ),
    //   JoystickAction(
    //     actionId: 2,
    //     size: 50,
    //     color: const Color(0xFF00FF00),
    //     margin: const EdgeInsets.only(
    //       right: 50,
    //       bottom: 120,
    //     ),
    //   ),
    // ],
  );

  MyGame(this.size) {
    print("hallo game " + size.toString());
    screenSize = size;
    tileSize = screenSize.width / 9;

    initialize();
  }

  void initialize() async {
    // resize(await Flame.util.initialDimensions());
    joystick.addObserver(player);
    add(background);
    add(player);
    add(joystick);

    addWidgetOverlay(
        "PauseMenu", // Your overlay identifier
        Positioned(
          top: 50,
          right: 50,
          child: IconButton(
              onPressed: () {
                print("click settings");
              },
              icon: Icon(Icons.settings, color: Colors.white)),
        ));

    enemies = List<Enemy>();
    rnd = Random();

    spawnEnemies();
  }

  void spawnEnemies() {
    enemy = Enemy(this);
    enemies.add(enemy);
    add(enemy);

    Timer(Duration(milliseconds: 7000), () {
      spawnEnemies();
    });
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  @override
  void update(double t) {
    enemies.forEach((enemy) {
      if (enemy.enemyRect != null) {
        if (player.rect.overlaps(enemy.enemyRect)) {
          crash = true;

          addWidgetOverlay(
              "PauseMenu", // Your overlay identifier
              Positioned(
                top: 50,
                right: 50,
                child: Container(
                  width: 300,
                  height: 100,
                  color: Colors.white,
                ),
              ));
        }
      }
    });

    super.update(t);
  }

  void onTapDown(TapDownDetails d) {
    // flies.forEach((Player fly) {
    //   if (fly.flyRect.contains(d.globalPosition)) {
    //     fly.onTapDown();
    //   }
    // });
  }

  @override
  void onReceiveDrag(DragEvent drag) {
    joystick.onReceiveDrag(drag);
    super.onReceiveDrag(drag);
  }
}

// import 'dart:async';
// import 'dart:math' as math;
// import 'dart:math';
// import 'dart:ui';

// import 'package:flame/anchor.dart';
// import 'package:flame/components/joystick/joystick_component.dart';
// import 'package:flame/components/joystick/joystick_directional.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/gestures.dart';
// import 'package:flame/components/component.dart';
// import 'package:flame/components/mixins/has_game_ref.dart';
// import 'package:flame/game.dart';
// import 'package:flame/palette.dart';
// import 'package:flutter/material.dart';

// import 'components/background.dart';
// import 'components/player.dart';
// import 'components/enemy.dart';

// class Palette {
//   static const PaletteEntry white = BasicPalette.white;
//   static const PaletteEntry red = PaletteEntry(Color(0xFFFF0000));
//   static const PaletteEntry blue = PaletteEntry(Color(0xFF0000FF));
// }

// class Square extends PositionComponent with HasGameRef<MyGame> {
//   static const SPEED = 0.25;

//   @override
//   void render(Canvas c) {
//     prepareCanvas(c);

//     c.drawRect(Rect.fromLTWH(0, 0, width, height), Palette.white.paint);
//     c.drawRect(const Rect.fromLTWH(0, 0, 3, 3), Palette.red.paint);
//     c.drawRect(Rect.fromLTWH(width / 2, height / 2, 3, 3), Palette.blue.paint);
//   }

//   @override
//   void update(double t) {
//     super.update(t);
//     angle += SPEED * t;
//     angle %= 2 * math.pi;
//   }

//   @override
//   void onMount() {
//     width = height = gameRef.squareSize;
//     anchor = Anchor.center;
//   }
// }

// class MyGame extends BaseGame
//     with
//         DoubleTapDetector,
//         TapDetector,
//         MultiTouchDragDetector,
//         HasWidgetsOverlay {
//   final double squareSize = 128;
//   bool running = true;

//   Size screenSize;
//   double tileSize;
//   bool crash;
//   Enemy enemy;

//   Random rnd;
//   List<Enemy> enemies;

//   final Background background = Background();
//   final Player player = Player();

//   final joystick = JoystickComponent(
//     directional: JoystickDirectional(
//       // spriteBackgroundDirectional: Sprite('directional_background.png'), // optional
//       // spriteKnobDirectional: Sprite('directional_knob.png'), // optional
//       isFixed: false, // optional
//       margin: const EdgeInsets.only(left: 100, bottom: 100), // optional
//       size: 80, // optional
//       color: Colors.blueGrey, // optional
//       opacityBackground: 0.5, // optional
//       opacityKnob: 0.8, // optional
//     ),
//   );

//   MyGame() {
//     add(Square()
//       ..x = 100
//       ..y = 100);
//     initialize();
//     // joystick.addObserver(player);

//     // add(background);
//     // add(player);

//     // add(joystick);

//     // enemies = List<Enemy>();
//     // rnd = Random();

//     // spawnEnemies();

//     // addWidgetOverlay(
//     //     "PauseMenu", // Your overlay identifier
//     //     Positioned(
//     //       top: 50,
//     //       right: 50,
//     //       child: IconButton(
//     //           onPressed: () {
//     //             print("click settings");
//     //           },
//     //           icon: Icon(Icons.settings, color: Colors.white)),
//     //     ));
//   }

//   void initialize() async {
//     resize(await Flame.util.initialDimensions());
//     joystick.addObserver(player);
//     add(background);
//     add(player);
//     add(joystick);

//     // addWidgetOverlay(
//     //     "PauseMenu", // Your overlay identifier
//     //     Positioned(
//     //       top: 50,
//     //       right: 50,
//     //       child: IconButton(
//     //           onPressed: () {
//     //             print("click settings");
//     //           },
//     //           icon: Icon(Icons.settings, color: Colors.white)),
//     //     ));

//     enemies = List<Enemy>();
//     rnd = Random();

//     spawnEnemies();
//   }

//   void spawnEnemies() {
//     print(screenSize);
//     enemy = Enemy(this);
//     enemies.add(enemy);
//     add(enemy);

//     Timer(Duration(milliseconds: 7000), () {
//       spawnEnemies();
//     });
//   }

//   @override
//   void update(double t) {
//     enemies.forEach((enemy) {
//       if (enemy.enemyRect != null) {
//         if (player.rect.overlaps(enemy.enemyRect)) {
//           crash = true;

//           addWidgetOverlay(
//               "PauseMenu", // Your overlay identifier
//               Positioned(
//                 top: 50,
//                 right: 50,
//                 child: Container(
//                   width: 300,
//                   height: 100,
//                   color: Colors.white,
//                 ),
//               ));
//         }
//       }
//     });
//     super.update(t);
//   }

//   @override
//   void resize(Size size) {
//     print("resize");
//     screenSize = size;
//     tileSize = screenSize.width / 9;
//     super.resize(size);
//   }

//   @override
//   void onReceiveDrag(DragEvent drag) {
//     joystick.onReceiveDrag(drag);
//     super.onReceiveDrag(drag);
//   }

//   @override
//   void onTapUp(details) {
//     final touchArea = Rect.fromCenter(
//       center: details.localPosition,
//       width: 20,
//       height: 20,
//     );

//     bool handled = false;
//     components.forEach((c) {
//       if (c is PositionComponent && c.toRect().overlaps(touchArea)) {
//         handled = true;
//         markToRemove(c);
//       }
//     });

//     if (!handled) {
//       addLater(Square()
//         ..x = touchArea.left
//         ..y = touchArea.top);
//     }
//   }

//   @override
//   void onDoubleTap() {
//     if (running) {
//       pauseEngine();
//     } else {
//       resumeEngine();
//     }

//     running = !running;
//   }
// }
