import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';

class EventScreen extends Screen {
  @override
  String imageToRender(World world) {
    return "event";
  }

  @override
  Future<Screen> transitionOnInput(KeyCode keyCode, World world) async {
    return this;
  }
}
