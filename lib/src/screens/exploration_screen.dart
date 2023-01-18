import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';
import 'package:rpg/src/screens/day_over_screen.dart';
import 'package:rpg/src/screens/fight_screen.dart';
import 'package:rpg/src/screens/inventory_screen.dart';
import 'package:rpg/src/screens/player_stats_screen.dart';
import 'package:rpg/src/sprites.dart';
import 'package:rpg/src/utils.dart';

import '../renderer.dart';

const animationFrameTime = 100;

class ExplorationScreen extends Screen {
  String environmentSprite = "";
  int shift = -30;
  String? message;
  bool interactive = false;

  void reset() {
    shift = 0;
    interactive = true;
  }

  ExplorationScreen._random() {
    environmentSprite =
        [tree1, tree2, tree3, tree4, tree5, tree6, mountain1].randomElement();
  }

  static Future<ExplorationScreen> random(world) async {
    var screen = ExplorationScreen._random();
    await screen.runStartUpAnimation(world);
    return screen;
  }

  Future<void> runStartUpAnimation(World world) async {
    render(world);
    for (var i = 5; i > 0; i--) {
      shift += i * 2;
      await waitMS(animationFrameTime);
      if (i == 1) {
        interactive = true;
      }
      render(world);
    }
    interactive = true;
  }

  Future<void> runPhaseOutAnimation(World world) async {
    interactive = false;
    for (var i = 1; i <= 5; i++) {
      shift += i * 2;
      render(world);
      await waitMS(animationFrameTime);
    }
  }

  @override
  String imageToRender(World world) {
    String screen = """
${timeDisplay(world)}
$separationLine
${spriteShift(environmentSprite, shift)}

${playerMiniatureDisplay(world)}${messageDisplay(message)}
$separationLine

""";
    if (interactive) {
      screen += """
${blue("[${CONTINUE_KEY.name.toUpperCase()}]  explore")}
${blue("[${CHARACTER_KEY.name.toUpperCase()}]  character skills")}
${blue("[${INVENTORY_KEY.name.toUpperCase()}]  inventory")}
""";
    }
    return screen;
  }

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    if (keyCode == CHARACTER_KEY) {
      return CharacterScreen(previousScreen: this);
    }
    if (keyCode == INVENTORY_KEY) {
      return InventoryScreen(previousScreen: this);
    }
    // explore:
    if (keyCode == CONTINUE_KEY) {
      await runPhaseOutAnimation(world);
      if (world.dayIsOver()) {
        return DayOverScreen();
      }
      Map<double, Future<Screen> Function()> m = {
        9.8: () async {
          // go into a fight
          return FightScreen.random(explorationScreen: this);
        },
        0.0: () async {
          world.increaseDayHour();
          return await ExplorationScreen.random(world);
        }
      };
      return await m.randomElement()();
    }
    return this;
    // (world);
  }
}
