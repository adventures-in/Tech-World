import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/rendering.dart';
import 'package:tech_world/drawing/player_component.dart';

class PlayersService {
  late final PlayerComponent? _player1;
  final Map<String, PlayerComponent> _otherPlayers = {};

  void update(double dt) {
    _player1?.update(dt);

    for (var player in _otherPlayers.values) {
      player.update(dt);
    }
  }

  void render(Canvas canvas) {
    _player1?.render(canvas);

    for (var player in _otherPlayers.values) {
      player.render(canvas);
    }
  }

  Future<void> updatePlayers(ISet<String> otherPlayerIds) async {
    // Add a player for any new character that came through in the game state.
    print('there were ${_otherPlayers.length} other players...');
    for (final playerId in otherPlayerIds) {
      if (!_otherPlayers.containsKey(playerId)) {
        _otherPlayers[playerId] =
            await PlayerComponent.create('bald.png', start: Position(50, 50));
      }
    }
    print('now there are ${_otherPlayers.length}.');
  }

  // Create a character at the origin for player1.
  Future<PlayerComponent> createPlayer1Avatar() async {
    _player1 = await PlayerComponent.create('bald.png', start: Position(0, 0));

    return _player1!;
  }
}
