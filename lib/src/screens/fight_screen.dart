import 'package:rpg/src/dices.dart';
import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';
import 'package:rpg/src/screens/exploration_screen.dart';

import '../monster.dart';
import '../monsters/tiger.dart';
import '../player.dart';
import '../renderer.dart';

class FightScreen implements Screen {
  late ExplorationScreen explorationScreen;
  late Monster monster;
  String? message;
  FightScreen.random({required this.explorationScreen}) {
    monster = Tiger(); // todo
    message = "Oh wow! A dangerous ${monster.name}!";
  }

  @override
  String imageToRender(World world) {
    return """                  FIGHT
$separationLine

          ${monsterLPDisplay(monster)}
           
${monster.sprite}
${playerMiniatureDisplay(world)}
${messageDisplay(message)}
$separationLine

${blue("[A]  attack with ${world.player.activeFightingSkill}")}
${blue("[D]  defend the next attack")}
${blue("[E]  try to escape")}
${blue("[S]  open character stats")}
""";
  }

  @override
  Screen transitionOnInput(KeyCode keyCode, World world) {
    if (keyCode == KeyCode.a) {
      var player = world.player;
      // attack:

      // monster always attack, todo: change in future to also possible to defend.
      final playerAttack = SkillTest.roll(
          monster.defenseSkill, player.skills[player.activeFightingSkill]!);
      final monsterAttack =
          SkillTest.roll(monster.attackSkill, player.skills[Skill.dodge]!);

      if (player.skills[Skill.reflexes]! >= monster.reflexesSkill) {
        // monster.takeDamage(   )
      }
    }
    return this;
  }
}
