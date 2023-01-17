import 'package:rpg/src/dices.dart';
import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';
import 'package:rpg/src/screens/exploration_screen.dart';

import '../monster.dart';
import '../monsters/tiger.dart';
import '../player.dart';
import '../renderer.dart';

class FightScreen extends Screen {
  late ExplorationScreen explorationScreen;
  late Monster monster;
  String? message;
  bool interactive = true;

  FightScreen.random({required this.explorationScreen}) {
    monster = Tiger(); // todo
    message = "Oh wow! A dangerous ${monster.name}!";
  }

  @override
  String imageToRender(World world) {
    var screen = """                  FIGHT
$separationLine

                     ${monsterLPDisplay(monster)}
                     ${monsterDmgDisplay(monster)}
                     ${monsterIniDisplay(monster)}
           
${monster.sprite}
${playerMiniatureDisplay(world)}
${messageDisplay(message)}
$separationLine
""";
    if (interactive && !monster.dead) {
      screen += """
${blue("[A]  attack with ${world.player.activeFightingSkill}")}
${blue("[D]  defend the next attack")}
${blue("[E]  try to escape")}
${blue("[S]  open character stats")}
""";
    }

    if (interactive && monster.dead) {
      screen += """
${blue("[SPACE]  explore.")}
${blue("[S]  open character stats")}
""";
    }
    return screen;
  }

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    if (keyCode == KeyCode.a) {
      var player = world.player;
      // attack:

      // monster always attack, todo: change in future to also possible to defend.

      List<String> attackLog = [];
      flushAndRender() async {
        message = attackLog.join("\n");
        interactive = false;
        render(world);
        await Future.delayed(Duration(milliseconds: 600));
      }

      Future<void> doPlayerAttack() async {
        final playerAttack = SkillTest.roll(
            monster.defenseSkill, player.skills[player.activeFightingSkill]!);
        if (playerAttack.failed) {
          attackLog.add("${player.name} misses...");
          await flushAndRender();
        } else {
          var dmg = player.activeWeapon.dmgFunction();
          monster.takeDamage(dmg);
          attackLog.add("${player.name} hits ${monster.name} ($dmg dmg).");
          if (monster.dead) {
            attackLog.add("${player.name} killed ${monster.name}!");
          }
          await flushAndRender();
        }
      }

      Future<void> doMonsterAttack() async {
        final monsterAttack =
            SkillTest.roll(monster.attackSkill, player.skills[Skill.dodge]!);
        if (monsterAttack.failed) {
          attackLog.add("${monster.name} misses...");
          await flushAndRender();
        } else {
          var monsterDmg = monster.dmgFunction();
          player.takeDamage(monsterDmg);
          attackLog
              .add("${monster.name} hits ${player.name} ($monsterDmg dmg).");
          if (player.dead) {
            attackLog.add("${monster.name} killed ${player.name}!");
          }
          await flushAndRender();
        }

        return;
      }

      if (player.skills[Skill.reflexes]! >= monster.reflexesSkill) {
        await doPlayerAttack();
        if (!monster.dead) {
          await doMonsterAttack();
        }
      } else {
        await doMonsterAttack();
        if (!player.dead) {
          await doPlayerAttack();
        }
      }
      interactive = true;
      render(world);
    }
    return this;
  }
}
