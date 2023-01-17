import 'package:rpg/src/input.dart';
import 'package:rpg/rpg.dart';
import 'package:rpg/src/screen.dart';

import '../player.dart';
import '../renderer.dart';

class PlayerStatsScreen extends Screen {
  late Screen previousScreen;
  @override
  String imageToRender(World world) {
    var player = world.player;
    final screen = """

SKILLS:                              
   ${blue("search")}: ${yellow(player.skills[Skill.search].toString())}
  ${blue("evasion")}: ${yellow(player.skills[Skill.dodge].toString())}
     ${blue("axes")}: ${yellow(player.skills[Skill.axe].toString())}                           
   ${blue("swords")}: ${yellow(player.skills[Skill.sword].toString())}                            
  ${blue("daggers")}: ${yellow(player.skills[Skill.dagger].toString())}                            
 ${blue("throwing")}: ${yellow(player.skills[Skill.throwing].toString())}        
 ${blue("reflexes")}: ${yellow(player.skills[Skill.reflexes].toString())}                      
                                  
$separationLine
[Q] to close screen
[1] invest ${green("1XP")} to increase ${blue("search")}

""";
    return screen;
  }

  @override
  Screen transitionOnInput(KeyCode keyCode, World world) {
    if (keyCode == KeyCode.q || keyCode == KeyCode.esc) {
      return previousScreen;
    }
    // todo: leveling
    return this;
  }

  PlayerStatsScreen({required this.previousScreen});
}
