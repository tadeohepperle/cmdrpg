import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';

import '../item.dart';
import '../player.dart';
import '../renderer.dart';

class InventoryScreen extends Screen {
  late Screen previousScreen;
  int selectedItemIndex = 0;

  @override
  String imageToRender(World world) {
    var player = world.player;
    final screen = """
                INVENTORY
$separationLine     

${player.inventory.toList().asMap().map((i, e) {
              Item item = e.key;
              String active = player.activeWeapon == item ? "(equipped)" : "";
              String displ = "    ${e.value} x ${item} ${active}";
              if (item is Weapon) {
                displ +=
                    "\n        ${item.dmgFunctionString} (${item.weaponSkill.name})";
              }
              if (selectedItemIndex == i) {
                displ =
                    displ.split("\n").map((e) => blue(e).toString()).join("\n");
              }

              return MapEntry(i, displ);
            }).entries.map((e) => e.value).join("\n")}

${playerMiniatureDisplay(world)}               
$separationLine
${blue("[${CLOSE_KEY.name.toUpperCase()}]  close inventory")}
${blue("[${ACCEPT_KEY.name.toUpperCase()}] equip ${player.inventory.toList()[selectedItemIndex].key.name} ")}
${blue("[${UP_KEY.name.toUpperCase()}]  ⇧ choose skill above")}
${blue("[${DOWN_KEY.name.toUpperCase()}]  ⇩ choose skill below")}
""";
    return screen;
  }

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    if (keyCode == CLOSE_KEY) {
      return previousScreen;
    }
    if (keyCode == UP_KEY || keyCode == DOWN_KEY) {
      selectedItemIndex = selectedItemIndex + (keyCode == UP_KEY ? -1 : 1);
      selectedItemIndex = selectedItemIndex.clamp(
          0, world.player.inventory.toList().length - 1);
      render(world);
    }
    if (keyCode == ACCEPT_KEY) {
      // var player = world.player;
      // int upgradeCost = _upgradeSkillCost(player);
      // bool upgradePossible = _upgradeSkillPossible(player, upgradeCost);
      // if (upgradePossible) {
      //   player.xp -= upgradeCost;
      //   player.skills[activeSkill] = player.skills[activeSkill]! + 1;
      // }
    }
    return this;
  }

  InventoryScreen({required this.previousScreen});
}
