import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';
import 'package:rpg/src/screens/day_over_screen.dart';
import 'package:rpg/src/screens/fight_screen.dart';
import 'package:rpg/src/screens/player_stats_screen.dart';
import 'package:rpg/src/sprites.dart';
import 'package:rpg/src/utils.dart';

import '../renderer.dart';

class ExplorationScreen implements Screen {
  String environmentSprite = "";
  String? message;
  ExplorationScreen.random() {
    environmentSprite =
        [tree1, tree2, tree3, tree4, tree5, tree6, mountain1].randomElement();
  }

  @override
  String imageToRender(World world) {
    String screen = """
              ${timeDisplay(world)}
$separationLine
$environmentSprite

${playerMiniatureDisplay(world)}
${messageDisplay(message)}
$separationLine

${blue("[SPACE] explore")}
${blue("[S] open character stats")}
""";
    return screen;
  }

  @override
  Screen transitionOnInput(KeyCode keyCode, World world) {
    if (keyCode == KeyCode.s) {
      return PlayerStatsScreen(previousScreen: this);
    }
    // explore:
    if (keyCode == KeyCode.space) {
      if (world.dayIsOver()) {
        return DayOverScreen();
      }
      Map<double, Screen Function()> m = {
        9.8: () {
          // go into a fight
          return FightScreen.random(explorationScreen: this);
        },
        0.01: () {
          // explore more, show a different screen than the one we already have
          world.increaseDayHour();
          var newExplorationScreen = ExplorationScreen.random();
          while (newExplorationScreen.environmentSprite == environmentSprite) {
            newExplorationScreen = ExplorationScreen.random();
          }
          return newExplorationScreen;
        }
      };
      return m.randomElement()();
    }
    return this;
    // (world);
  }
}
