import 'package:rpg/src/input.dart';

import 'package:rpg/rpg.dart';

import '../loot.dart';
import '../renderer.dart';
import '../screen.dart';

class LootScreen extends Screen {
  late Screen nextScreen;
  late Loot loot;

  @override
  String imageToRender(World world) {
    return """                  LOOT
$separationLine

                  ${green("+${loot.xp} XP")}
                  ${yellow("+${loot.gold} gold")}

${loot.items.map((e) => e.name.padLeft((41 - e.name.length) ~/ 2)).join("\n")}

${playerMiniatureDisplay(world)}
$separationLine

${blue("[${CONTINUE_KEY.name.toUpperCase()}]  take the loot")}
""";
  }

  LootScreen({required this.nextScreen, required this.loot});

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    if (keyCode == CONTINUE_KEY) {
      world.player.inventory.addAll(loot.items);
      world.player.xp += loot.xp;
      world.player.gold += loot.gold;
      return nextScreen;
    }
    return this;
  }
}
