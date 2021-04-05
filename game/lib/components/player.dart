import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/gestures.dart';
import 'dart:math' as math;

class MyCrate extends SpriteComponent with Draggable {
  MyCrate() : super(size: Vector2.all(50.0));

  var screenWidth;
  var screenHeight;

  static const speed = 0.25;
  static const squareSize = 128.0;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('test.png');
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    angle += speed * dt;
    angle %= 2 * math.pi;
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    position = gameSize / 2;
    screenWidth = gameSize.x;
    screenHeight = gameSize.y;
    super.onGameResize(gameSize);
  }

  // @override
  // bool onDragStart(int pointerId, Vector2 startPosition) {
  //   // print(startPosition);
  //   // TODO: implement onDragStart
  //   return super.onDragStart(pointerId, startPosition);
  // }

  // @override
  // bool onDragUpdate(int pointerId, DragUpdateDetails details) {
  //   print(details.globalPosition);
  //   return super.onDragUpdate(pointerId, details);
  // }

  Vector2 dragDeltaPosition;
  bool get isDragging => dragDeltaPosition != null;

  @override
  bool onDragStart(int pointerId, Vector2 startPosition) {
    print("lol");
    dragDeltaPosition = startPosition - position;
    return false;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateDetails details) {
    // final localCoords = gameref.convertGlobalToLocalCoordinate(
    //   details.globalPosition,
    // );

    this.position =
        Vector2(details.globalPosition.dx, details.globalPosition.dy);

    // position = localCoords - dragDeltaPosition;
    return false;
  }

  @override
  bool onDragEnd(int pointerId, DragEndDetails details) {
    dragDeltaPosition = null;
    return false;
  }

  @override
  bool onDragCancel(int pointerId) {
    dragDeltaPosition = null;
    return false;
  }
}

class PlayerTest extends SpriteComponent {
  final size = Vector2.all(128.0);

  @override
  void render(Canvas c) {
    super.render(c);

    // c.drawRect(this.size.toRect(), _paint);
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

    final size = Vector2.all(128.0);
    // var player = SpriteComponent.fromSprite(size, sprite);
  }

  // PlayerTest() {
  //   load().then((value) => print("sal"));
  // }

  Future<void> load() async {
    Image image = await Flame.images.load('test.png');

    // print(image);

    // player = Sprite(image);
  }
}

class Player extends Component implements JoystickListener {
  final Size screenSize;

  final _whitePaint = BasicPalette.white.paint;
  final _bluePaint = Paint()..color = const Color(0xFF0000FF);
  final _greenPaint = Paint()..color = const Color(0xFF00FF00);
  final double speed = 159;
  double currentSpeed = 0;
  double radAngle = 0;
  bool _move = false;
  Paint _paint;

  Rect rect;

  Player({this.screenSize}) {
    _paint = _whitePaint;
  }

  @override
  void render(Canvas canvas) {
    if (rect != null) {
      canvas.save();
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate(radAngle == 0.0 ? 0.0 : radAngle + (pi / 2));
      canvas.translate(-rect.center.dx, -rect.center.dy);
      canvas.drawRect(rect, _paint);
      canvas.restore();
    }
  }

  @override
  void update(double dt) {
    if (_move) {
      moveFromAngle(dt);
    }
  }

  @override
  void rescreenSize(Size screenSize) {
    rect = Rect.fromLTWH(
      (screenSize.width / 2) - 25,
      (screenSize.height / 2) - 25,
      50,
      50,
    );
  }

  // @override
  // void joystickAction(JoystickActionEvent event) {
  //   if (event.event == ActionEvent.DOWN) {
  //     if (event.id == 1) {
  //       _paint = _paint == _whitePaint ? _bluePaint : _whitePaint;
  //     }
  //     if (event.id == 2) {
  //       _paint = _paint == _whitePaint ? _greenPaint : _whitePaint;
  //     }
  //   }
  // }

  // @override
  // void joystickChangeDirectional(JoystickDirectionalEvent event) {
  //   _move = event.directional != JoystickMoveDirectional.IDLE;
  //   if (_move) {
  //     radAngle = event.radAngle;
  //     currentSpeed = speed * event.intensity;
  //   }
  // }

  void moveFromAngle(double dtUpdate) {
    final double nextX = (currentSpeed * dtUpdate) * cos(radAngle);
    final double nextY = (currentSpeed * dtUpdate) * sin(radAngle);
    final Offset nextPoint = Offset(nextX, nextY);

    final Offset diffBase = Offset(
          rect.center.dx + nextPoint.dx,
          rect.center.dy + nextPoint.dy,
        ) -
        rect.center;

    final Rect newPosition = rect.shift(diffBase);

    rect = newPosition;
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    // TODO: implement joystickAction
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    // TODO: implement joystickChangeDirectional
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

//   void onTapDown() {
//     move = true;
//     jump = true;

//     flyPaint.color = Colors.green;
//     // game.spawnFly();
//   }
