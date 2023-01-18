import 'package:rpg/src/dices.dart';
import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';
import 'package:rpg/src/screens/death_screen.dart';
import 'package:rpg/src/screens/exploration_screen.dart';
import 'package:rpg/src/screens/inventory_screen.dart';
import 'package:rpg/src/screens/loot_screen.dart';
import 'package:rpg/src/screens/player_stats_screen.dart';
import 'package:rpg/src/utils.dart';

import '../monster.dart';
import '../monsters/tiger.dart';
import '../player.dart';
import '../renderer.dart';

class FightScreen extends Screen {
  late ExplorationScreen explorationScreen;
  late Monster monster;
  int monsterSpriteShift = 0;
  int playerSpriteShift = 0;
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
           
${spriteShift(monster.sprite, monsterSpriteShift)}
${spriteShift(playerMiniatureDisplay(world), playerSpriteShift)}
${messageDisplay(message)}
$separationLine

""";
    if (interactive && !monster.dead) {
      screen += """
${blue("[${ATTACK_KEY.name.toUpperCase()}]  attack with ${world.player.activeFightingSkill.name}")}
${blue("[${ESCAPE_KEY.name.toUpperCase()}]  try to escape")}
${blue("[${CHARACTER_KEY.name.toUpperCase()}]  character skills")}
${blue("[${INVENTORY_KEY.name.toUpperCase()}]  inventory")}
""";
    }

    if (interactive && monster.dead) {
      screen += """
${blue("[${CONTINUE_KEY.name.toUpperCase()}]  collect loot")}
${blue("[${CHARACTER_KEY.name.toUpperCase()}]  character skills")}
${blue("[${INVENTORY_KEY.name.toUpperCase()}]  inventory")}
""";
    }
    return screen;
  }

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    if (!interactive) return this;
    if (keyCode == CHARACTER_KEY) {
      return CharacterScreen(previousScreen: this);
    }
    if (keyCode == INVENTORY_KEY) {
      return InventoryScreen(previousScreen: this);
    }
    if (monster.dead && keyCode == CONTINUE_KEY) {
      explorationScreen.shift = 0;
      explorationScreen.interactive = true;
      return LootScreen(nextScreen: explorationScreen, loot: monster.loot);
    }
    if (!monster.dead) {
      /// MAIN FIGHTING SECTION:
      var player = world.player;

      message = "";
      render(world);
      waitMS(50);
      messageAdd(String s) =>
          message = message! + (message!.isEmpty ? "" : "\n") + s;

      Future<void> doPlayerAttack() async {
        final playerAttack = SkillTest.roll(
            monster.defenseSkill, player.skills[player.activeFightingSkill]!);
        if (playerAttack.failed) {
          messageAdd("${player.name} misses...");
          render(world);
          await waitMS(100);
        } else {
          monsterSpriteShift = 4;
          render(world);
          await waitMS(50);
          monsterSpriteShift = -4;
          render(world);
          await waitMS(50);
          var dmg = player.activeWeapon.dmgFunction();
          monster.takeDamage(dmg);
          messageAdd("${player.name} hits ${monster.name} ($dmg dmg).");
          if (monster.dead) {
            messageAdd("${player.name} killed ${monster.name}!");
          }
          monsterSpriteShift = 0;
          render(world);
          await waitMS(50);
        }
      }

      Future<void> doMonsterAttack() async {
        final monsterAttack =
            SkillTest.roll(monster.attackSkill, player.skills[Skill.dodge]!);
        if (monsterAttack.failed) {
          messageAdd("${monster.name} misses...");
          render(world);
          await waitMS(100);
        } else {
          playerSpriteShift = 4;
          render(world);
          await waitMS(50);
          playerSpriteShift = -4;
          render(world);
          await waitMS(50);
          var monsterDmg = monster.dmgFunction();
          player.takeDamage(monsterDmg);
          messageAdd("${monster.name} hits ${player.name} ($monsterDmg dmg).");
          if (player.dead) {
            messageAdd("${monster.name} killed ${player.name}!");
          }
          playerSpriteShift = 0;
          render(world);
          waitMS(50);
        }

        return;
      }

      /// ATTACK
      if (keyCode == ATTACK_KEY) {
        interactive = false;
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
        if (player.dead) {
          waitMS(1000);
          return DeathScreen();
        }

        interactive = true;
        render(world);
      }

      /// ESCAPING
      if (keyCode == ESCAPE_KEY) {
        interactive = false;
        var escapeSkillTest =
            SkillTest.roll(monster.attackSkill, player.skills[Skill.dodge]!);
        if (escapeSkillTest.passed) {
          messageAdd("${player.name} successfully escaped!");
          render(world);
          explorationScreen.reset();
          await waitMS(1000);
          return explorationScreen;
        } else {
          messageAdd("${player.name} failed to escape!");
          render(world);
          await waitMS(200);
          await doMonsterAttack();

          if (player.dead) {
            waitMS(1000);
            return DeathScreen();
          }

          interactive = true;
          render(world);
        }
      }
    }

    return this;
  }
}
