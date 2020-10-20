import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/components/joystick/joystick_events.dart';
import 'package:flame/palette.dart';

class Player extends Component implements JoystickListener {
  final _whitePaint = BasicPalette.white.paint;

  final _bluePaint = Paint()..color = const Color(0xFF0000FF);
  final _greenPaint = Paint()..color = const Color(0xFF00FF00);
  final double speed = 159;
  double currentSpeed = 0;
  double radAngle = 0;
  bool _move = false;
  Paint _paint;

  Rect rect;

  Player() {
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
  void resize(Size size) {
    rect = Rect.fromLTWH(
      (size.width / 2) - 25,
      (size.height / 2) - 25,
      50,
      50,
    );
    super.resize(size);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN) {
      if (event.id == 1) {
        _paint = _paint == _whitePaint ? _bluePaint : _whitePaint;
      }
      if (event.id == 2) {
        _paint = _paint == _whitePaint ? _greenPaint : _whitePaint;
      }
    }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    _move = event.directional != JoystickMoveDirectional.IDLE;
    if (_move) {
      radAngle = event.radAngle;
      currentSpeed = speed * event.intensity;
    }
  }

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

//   void onTapDown() {
//     move = true;
//     jump = true;

//     flyPaint.color = Colors.green;
//     // game.spawnFly();
//   }
