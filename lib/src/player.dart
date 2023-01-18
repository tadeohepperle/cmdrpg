import 'package:rpg/src/dices.dart';

import 'item.dart';
import 'utils.dart';

enum Skill { search, dodge, axe, sword, brawling, throwing, reflexes }

class Player {
  Map<Skill, int> skills = {};
  String name;
  MultiSet<Item> inventory = MultiSet();
  int gold = 0;
  int xp = 100;
  int lp = 20;
  int maxlp = 20;

  Player(this.name) {
    skills = randomStartingSkills();
    inventory.addAll([
      Item("roses"),
      Weapon("short sword", () => d6, "d6 + 2",
          value: 4, weaponSkill: Skill.sword),
      Weapon("combat gloves", () => d6, "d6 + 1",
          value: 4, weaponSkill: Skill.brawling)
    ]);
  }

  Skill get activeFightingSkill => activeWeapon.weaponSkill;

  Weapon get activeWeapon => _activeWeaponFromInventory ?? _defaultBodyWeapon;

  Weapon? _activeWeaponFromInventory;

  final Weapon _defaultBodyWeapon = Weapon("fists", () => d6, "d6 - 1",
      value: 0, weaponSkill: Skill.brawling);

  void takeDamage(int dmg) {
    lp -= dmg;
    if (lp < 0) {
      lp = 0;
    }
  }

  bool get dead => lp <= 0;
}

const int startingSkillPoints = 10;
Map<Skill, int> randomStartingSkills() {
  Map<Skill, int> skillMap = {};
  // set all skills to 0
  for (var s in Skill.values) {
    skillMap[s] = 0;
  }
  for (var i = 0; i < startingSkillPoints; i++) {
    Skill randomSkill = Skill.values.randomElement();
    skillMap[randomSkill] = skillMap[randomSkill]! + 1;
  }
  return skillMap;
}
