import 'dart:io';

import 'package:rpg/src/screen.dart';
import 'package:rpg/src/input.dart';
import 'package:rpg/src/player.dart';
import 'package:rpg/src/renderer.dart';
import 'package:rpg/src/screens/start_screen.dart';

class World {
  late Player player;
  int _dayHour = 7;
  int _day = 0;
  int get day => _day;
  int get dayHour => _dayHour;
  World.newRandom(String playerName) {
    player = Player(playerName);
  }

  bool dayIsOver() => _dayHour >= 8;

  void goToNextDay() {
    _dayHour = 7;
    _day += 1;
  }

  void increaseDayHour() {
    _dayHour += 1;
  }
}

void runGame() async {
  stdin.echoMode = false;
  stdin.lineMode = false;
  // creating player:
  final playerName = "Adventurer";
  World world = World.newRandom(playerName);
  Screen screen = StartScreen();
  decorateScreenAndRender(screen.imageToRender(world));
  while (true) {
    KeyCode key = waitForKey();
    screen = await screen.transitionOnInput(key, world);
    decorateScreenAndRender(screen.imageToRender(world));
  }
}
