import 'package:colorize/colorize.dart';
import 'package:dart_console/dart_console.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/monster.dart';

Colorize yellow(String s) => Colorize(s).yellow();
Colorize inverted(String s) => Colorize(s).bgWhite();
Colorize blue(String s) => Colorize(s).lightBlue();
Colorize green(String s) => Colorize(s).lightGreen();
Colorize red(String s) => Colorize(s).red();

final console = Console();

const String separationLine =
    "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #";

const innerScreenWidth = 41;
String _decorateScreen(String screen) {
  final between = screen
      .split("\n")
      .map((e) => "# ${e.cutpadRight(innerScreenWidth)} #")
      .join("\n");
  final fullLine = "# ${separationLine.cutpadRight(innerScreenWidth)} #";
  return "$fullLine\n$between\n$fullLine";
}

decorateScreenAndRender(String screen) => _render(_decorateScreen(screen));

void _render(String screen) {
  console.resetCursorPosition();
  console.eraseCursorToEnd();
  console.clearScreen();
  console.resetCursorPosition();
  console.write(screen);
}

extension CutPad on String {
  String cutpadRight(int width) {
    final cleanString = replaceAll(RegExp(r'\x1B\[[0-?]*[ -/]*[@-~]'), '');
    if (cleanString.length > width) {
      return substring(0, width + this.length - cleanString.length);
    } else if (cleanString.length < width) {
      return this + " " * (width - cleanString.length);
    }
    return this;
  }
}

String timeDisplay(World world) {
  return "${world.day + 1}. day, ${world.dayHour}:00";
}

String monsterLPDisplay(Monster monster) {
  return red("${monster.name.padLeft(20)}  ${monster.lp}/${monster.maxlp}")
      .toString();
}

String playerMiniatureDisplay(World world) {
  var player = world.player;
  String sprite = r"""
      (") |>/<|                                    
      /X\  /                                     
     / X \/      Health  
      / \                                                                                     
     /   \     """;
  sprite = sprite.replaceFirst(
      "Health", red("${player.name}  ${player.lp}/${player.maxlp}").toString());
  return sprite;
}

String messageDisplay(String? message) {
  if (message == null) {
    return "";
  }
  return "\n$separationLine\n${yellow(message).toString()}";
}
