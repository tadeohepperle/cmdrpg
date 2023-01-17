import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';
import 'package:rpg/src/screens/exploration_screen.dart';
import 'package:rpg/src/screens/player_stats_screen.dart';

import '../renderer.dart';
import '../sprites.dart';

class DayOverScreen extends Screen {
  @override
  String imageToRender(World world) {
    String screen = """
${timeDisplay(world)}
$separationLine
$dayOver
${playerMiniatureDisplay(world)}
${messageDisplay("The day is over. \nTake a good rest.\nYou will heal.")}
$separationLine

${blue("[SPACE] sleep tight.")}
${blue("[S] open character stats")}
""";
    return screen;
  }

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    if (keyCode == KeyCode.s) {
      return PlayerStatsScreen(previousScreen: this);
    } else if (keyCode == KeyCode.space) {
      world.goToNextDay();
      return await ExplorationScreen.random(world);
    }
    return this;
  }
}
