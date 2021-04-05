import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'Game.dart';

void main() async {
  runApp(GameWidget(game: MyGame()));

  Flame.device.fullScreen();

  // await Flame.device.setOrientation(DeviceOrientation.portraitUp);

  // runApp(App());
}

void startGame() async {
  // final screenSize = await Flame.util.initialDimensions();
  // final game = MyGame(screenSize: screenSize);
  // runApp(GameWidget(game: game));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shadow Training',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lets go"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => startGame(),
                child: Text("Start"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Palette {
  static const PaletteEntry white = BasicPalette.white;
  static const PaletteEntry red = PaletteEntry(Color(0xFFFF0000));
  static const PaletteEntry blue = PaletteEntry(Color(0xFF0000FF));
}

class Square extends PositionComponent {
  static const speed = 0.25;
  static const squareSize = 128.0;

  static Paint white = Palette.white.paint;
  static Paint red = Palette.red.paint;
  static Paint blue = Palette.blue.paint;

  @override
  void render(Canvas c) {
    super.render(c);

    c.drawRect(size.toRect(), white);

    // c.drawRect(const Rect.fromLTWH(0, 0, 3, 3), red);
    c.drawRect(Rect.fromLTWH(width / 2, height / 2, 3, 3), blue);
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  void onMount() {
    super.onMount();
    size = Vector2.all(squareSize);

    this.x = 350;
    this.y = 530;

    anchor = Anchor.center;
  }
}

class BackgroundTest extends PositionComponent {
  Paint _paint;

  @override
  void render(Canvas c) {
    super.render(c);

    c.drawRect(this.size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // angle += speed * dt;
    // angle %= 2 * math.pi;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    this.size = gameSize;

    super.onGameResize(gameSize);
  }

  @override
  void onMount() {
    super.onMount();

    _paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, this.height),
        [
          Colors.redAccent,
          Colors.greenAccent,
        ],
      );

    // size = Vector2.all(squareSize);
  }
}

// class MyGame extends BaseGame with DoubleTapDetector, TapDetector {
//   bool running = true;

//   @override
//   Future<void> onLoad() async {
//     add(
//       Square()
//         ..x = 50
//         ..y = 50,
//     );
//   }

//   @override
//   void onTapUp(TapUpDetails details) {
//     final touchArea = Rect.fromCenter(
//       center: details.localPosition,
//       width: 20,
//       height: 20,
//     );

//     final handled = components.any((c) {
//       if (c is PositionComponent && c.toRect().overlaps(touchArea)) {
//         remove(c);
//         return true;
//       }
//       return false;
//     });

//     if (!handled) {
//       add(Square()
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
