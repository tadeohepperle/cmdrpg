import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/renderer.dart';
import 'package:rpg/src/screen.dart';
import 'package:rpg/src/sprites.dart';

class DeathScreen extends Screen {
  @override
  String imageToRender(World world) {
    String screen = """

$reaper

At some point everyone has to die.

$separationLine

${world.player.name} died not so peacefully.
He only lived for ${world.day + 1} ${world.day + 1 > 1 ? "days" : "day"}.
""";
    return screen;
  }

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    return this;
  }
}
