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
  String get sprite => """
  ("`-''-/").___..--''"`-._
     `6_ 6  )   `-.  (     ).`-.__.`)
     (_Y_.)'  ._   )  `._ `. ``-..-'
   _..`--'_..-_/  /--'_.' ,'
  (il),-''  (li),'  ((!.-'   

""";

  @override
  String get name => "Tiger";
}
