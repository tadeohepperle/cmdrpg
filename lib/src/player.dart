import 'item.dart';
import 'utils.dart';

enum Skill { search, dodge, axe, sword, dagger, throwing, reflexes }

class Player {
  Map<Skill, int> skills = {};
  String name;
  List<Item> inventory = [];
  int gold = 0;
  int xp = 0;
  int lp = 20;
  int maxlp = 20;

  Player(this.name) {
    skills = randomStartingSkills();
  }

  Skill get activeFightingSkill => activeWeapon.weaponSkill;

  Weapon get activeWeapon => _activeWeapon;

  final Weapon _activeWeapon = Weapons.shortSword;

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
