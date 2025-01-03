import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:provider/provider.dart';
import 'user_profile.dart'; // Make sure to import UserProfile

class MarketplaceGame extends FlameGame {
  late Player player;

  @override
  Future<void> onLoad() async {
    player = Player();
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update game logic here
  }
}

class Player extends SpriteComponent {
  Player() : super(size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('player.png'); // Use Sprite.load instead of loadSprite
    position = Vector2(100, 100); // Initial position
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Add player movement logic here
  }
}