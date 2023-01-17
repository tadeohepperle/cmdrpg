abstract class Monster {
  String get sprite;
  String get name;

  int get reflexesSkill;
  int get attackSkill;
  int get defenseSkill;

  void takeDamage(int dmg);
  int get lp;
  int get maxlp;
}

abstract class BaseMonster implements Monster {
  @override
  int reflexesSkill = 2;
  @override
  int attackSkill = 2;
  @override
  int defenseSkill = 2;

  @override
  int lp = 10;

  @override
  int maxlp = 10;

  String get sprite;

  @override
  String get name;
  void takeDamage(int dmg) {
    lp -= dmg;
    if (lp < 0) lp = 0;
  }
}
