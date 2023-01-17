import 'package:rpg/src/renderer.dart';

abstract class Monster {
  String get sprite;
  String get aliveSprite;
  String get deadSprite;
  String get name;

  int get reflexesSkill;
  int get attackSkill;
  int get defenseSkill;

  void takeDamage(int dmg);

  int Function() get dmgFunction;
  String get dmgFunctionString;
  int get lp;
  int get maxlp;

  bool get dead;
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

  @override
  String get sprite => dead ? deadSprite : aliveSprite;

  @override
  String get aliveSprite;

  @override
  String get deadSprite => aliveSprite.split("\n").map((e) => " ").join("\n");
  // int Function() get dmgFunction;

  @override
  String get name;

  @override
  void takeDamage(int dmg) {
    lp -= dmg;
    if (lp < 0) lp = 0;
  }

  @override
  bool get dead => lp <= 0;
}
