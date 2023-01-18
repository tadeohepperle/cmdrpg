import 'dart:math';

import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';

import '../player.dart';
import '../renderer.dart';

class CharacterScreen extends Screen {
  Skill activeSkill = Skill.sword;

  int _upgradeSkillCost(Player player) {
    int skillLevel = player.skills[activeSkill]!;
    return pow(skillLevel + 1, 1.5).toInt();
  }

  bool _upgradeSkillPossible(Player player, [int? cost]) {
    cost = cost ?? _upgradeSkillCost(player);
    return cost < player.xp;
  }

  late Screen previousScreen;
  @override
  String imageToRender(World world) {
    var player = world.player;

    int upgradeCost = _upgradeSkillCost(player);
    bool upgradePossible = _upgradeSkillPossible(player, upgradeCost);

    var colorFunUpgrade = upgradePossible ? blue : lightGray;

    var skillToFn = (Skill sk) => sk == activeSkill ? blue : (a) => a;
    var skillToText =
        (Skill sk) => skillToFn(sk)("${sk.name}: ${player.skills[sk]}");

    final screen = """                  SKILLS
$separationLine

                 ${skillToText(Skill.search)}
                ${skillToText(Skill.dodge)}
                   ${skillToText(Skill.axe)}                           
                 ${skillToText(Skill.sword)}                            
                ${skillToText(Skill.dagger)}                            
               ${skillToText(Skill.throwing)}        
               ${skillToText(Skill.reflexes)}                      

${playerMiniatureDisplay(world)}            

$separationLine

${blue("[${CLOSE_KEY.name.toUpperCase()}]  close screen")}
${colorFunUpgrade("[${ACCEPT_KEY.name.toUpperCase()}]  invest ")}${green("$upgradeCost XP")} ${colorFunUpgrade("to increase ${activeSkill.name}")}
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
      int i = activeSkill.index + (keyCode == UP_KEY ? -1 : 1);
      i = i.clamp(0, Skill.values.length - 1);
      activeSkill = Skill.values[i];

      render(world);
      print(keyCode);
    }
    if (keyCode == ACCEPT_KEY) {
      var player = world.player;
      int upgradeCost = _upgradeSkillCost(player);
      bool upgradePossible = _upgradeSkillPossible(player, upgradeCost);
      if (upgradePossible) {
        player.xp -= upgradeCost;
        player.skills[activeSkill] = player.skills[activeSkill]! + 1;
      }
    }

    // todo: leveling
    return this;
  }

  CharacterScreen({required this.previousScreen});
}
