import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';

import '../player.dart';
import '../renderer.dart';

class InventoryScreen extends Screen {
  late Screen previousScreen;
  @override
  String imageToRender(World world) {
    var player = world.player;
    final screen = """
                INVENTORY
$separationLine     

1x Item1 (equiqqed)
3x Item4
5x Flying Wings
1x  

${playerMiniatureDisplay(world)}            
               
$separationLine
${blue("[${CLOSE_KEY.name.toUpperCase()}]  close inventory")}
""";
    return screen;
  }

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    if (keyCode == CLOSE_KEY) {
      return previousScreen;
    }
    // todo: select weapon
    return this;
  }

  InventoryScreen({required this.previousScreen});
}
