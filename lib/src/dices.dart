import 'package:rpg/src/utils.dart';

int get d20 => randomInt(1, 21);
int get d10 => randomInt(1, 11);
int get d6 => randomInt(1, 7);

class SkillTest {
  late int difficulty;
  late int skillLevel;
  late int points;
  bool get passed => points >= 0;
  bool get isCrit => points.abs() >= 8;
  bool get failed => !passed;
  SkillTest.roll(this.difficulty, this.skillLevel) {
    points = skillLevel + d10 - d10 - difficulty;
  }
}
