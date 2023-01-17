import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';
import 'package:rpg/src/screens/exploration_screen.dart';

import '../renderer.dart';
import '../sprites.dart';

class DayOverScreen implements Screen {
  @override
  String imageToRender(World world) {
    String screen = """
${timeDisplay(world)}
$separationLine
$dayOver
The day is over. Take a good rest and see you in the morning.
$separationLine
  [SPACE] explore
""";
    return screen;
  }

  @override
  Screen transitionOnInput(KeyCode keyCode, World world) {
    if (keyCode == KeyCode.space) {
      world.goToNextDay();
      return ExplorationScreen.random();
    }
    return this;
  }
}
