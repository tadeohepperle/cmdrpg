import 'package:rpg/src/player.dart';

import 'dices.dart';

class Item {
  String name = "????";
  int value = 0;

  Item(this.name, {this.value = 0});
}

class Weapon extends Item {
  late int Function() dmgFunction;
  late String dmgFunctionString;
  late Skill weaponSkill;

  Weapon(String name, this.dmgFunction, this.dmgFunctionString,
      {int value = 0, this.weaponSkill = Skill.sword})
      : super(name, value: value);
}

abstract class Weapons {
  static Weapon get shortSword =>
      Weapon("short sword", () => d6 + 1, "d6 + 1", value: 3);
}
