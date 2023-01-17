import 'package:rpg/src/input.dart';

import '../rpg.dart';

abstract class Screen {
  Screen transitionOnInput(KeyCode keyCode, World world);

  // returns raw string which is then decorated by the renderer (border, padding, etc.)
  String imageToRender(World world);
}
