import 'package:rpg/src/dices.dart';
import 'package:rpg/src/item.dart';
import 'package:rpg/src/loot.dart';
import 'package:rpg/src/monster.dart';

class Tiger extends BaseMonster {
  Tiger() {
    reflexesSkill = 5;
    attackSkill = 3;
    defenseSkill = 1;
    maxlp = 10;
    lp = 10;
  }

  @override
  String get aliveSprite => """
  ("`-''-/").___..--''"`-._
     `6_ 6  )   `-.  (     ).`-.__.`)
     (_Y_.)'  ._   )  `._ `. ``-..-'
   _..`--'_..-_/  /--'_.' ,'
  (il),-''  (li),'  ((!.-'   

""";

  @override
  String get name => "Tiger";

  @override
  int Function() get dmgFunction => () => d10;

  @override
  String get dmgFunctionString => "d10";

  @override
  String get weaponName => "claws";

  @override
  Loot get loot => Loot(1, 2, [Item("fur"), Item("tiger head")]);
}
