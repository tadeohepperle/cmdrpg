import 'package:rpg/src/input.dart';
import 'package:rpg/src/renderer.dart';

import '../rpg.dart';

abstract class Screen {
  Future<Screen> transitionOnInput(KeyCode keyCode, World world);

  // returns raw string which is then decorated by the renderer (border, padding, etc.)
  String imageToRender(World world);

  void render(world) {
    decorateScreenAndRender(imageToRender(world));
  }
}
