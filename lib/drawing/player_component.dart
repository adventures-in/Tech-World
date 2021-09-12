import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:tech_world/enums/direction.dart';
import 'package:tech_world/utilities/effects/sprite_direction_animation_effect.dart';

typedef Position = Vector2;

class PlayerComponent extends SpriteAnimationGroupComponent<Direction> {
  // Private constructor - the async create method is how an object is created.
  PlayerComponent._(Map<Direction, SpriteAnimation> animations, Position start)
      : super(
            size: Vector2(64, 64),
            position: start,
            animations: animations,
            current: Direction.down);

  SpriteDirectionAnimationEffect? _animationEffect;
  MoveEffect? _moveEffect;

  // Static async create method so we can load sprite animations.
  static Future<PlayerComponent> create(String path,
      {required Position start}) async {
    final animations = <Direction, SpriteAnimation>{};

    // The x position of each sprite in the sprite sheet.
    const spriteX = <double>[192, 0, 96, 288];

    for (var direction in Direction.values) {
      animations[direction] = await SpriteAnimation.load(
          path,
          SpriteAnimationData.sequenced(
              amount: 3,
              textureSize: Vector2(32, 32),
              stepTime: 0.1,
              texturePosition: Vector2(spriteX[direction.index], 0)));
    }

    return PlayerComponent._(animations, start);
  }

  // void changeDirection(RawKeyEvent event) {
  //   if (event is RawKeyDownEvent) {
  //     current = Input.directionFrom(event);
  //     addEffect(
  //         MoveEffect(path: [current.vector], speed: 200.0, isRelative: true));
  //   }
  // }

  void move({required double speed, required List<Vector2> points}) {
    if (_animationEffect != null) removeEffect(_animationEffect!);
    if (_moveEffect != null) removeEffect(_moveEffect!);

    _animationEffect =
        SpriteDirectionAnimationEffect(speed: speed, pathPoints: points);
    _moveEffect = MoveEffect(speed: speed, path: points);

    addEffect(_animationEffect!);
    addEffect(_moveEffect!);
  }

  @override
  void update(double dt) => super.update(dt);
  @override
  void render(Canvas canvas) => super.render(canvas);
}
