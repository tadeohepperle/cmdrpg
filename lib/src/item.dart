import 'package:rpg/src/player.dart';

import 'dices.dart';

class Item implements Comparable {
  String name = "????";
  int value = 0;

  Item(this.name, {this.value = 0});

  @override
  int get hashCode => name.hashCode + value.hashCode;

  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }

  @override
  String toString() {
    return name;
  }

  @override
  int compareTo(other) {
    return name.compareTo(other.toString());
  }
}

class Weapon extends Item {
  late int Function() dmgFunction;
  late String dmgFunctionString;
  late Skill weaponSkill;

  Weapon(String name, this.dmgFunction, this.dmgFunctionString,
      {int value = 0, this.weaponSkill = Skill.sword})
      : super(name, value: value);

  @override
  int get hashCode =>
      name.hashCode +
      value.hashCode +
      dmgFunctionString.hashCode +
      weaponSkill.hashCode;
}

abstract class Weapons {
  static Weapon get shortSword =>
      Weapon("short sword", () => d6 + 1, "d6 + 1", value: 3);
}
