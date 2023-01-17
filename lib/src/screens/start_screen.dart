import 'package:rpg/src/input.dart';

import '../../rpg.dart';
import '../renderer.dart';
import '../screen.dart';
import 'exploration_screen.dart';

class StartScreen implements Screen {
  @override
  String imageToRender(World world) {
    final screen = r"""
                     _,._      
         .||,       /_ _\\     
        \.`',/      |'L'| |    
        = ,. =      | -,| L    
        / || \    ,-'\"/,'`.   
          ||     ,'   `,,. `.  
          ,|____,' , ,;' \| |  
         (3|\    _/|/'   _| |  
          ||/,-''  | >-'' _,\\ 
          ||'      ==\ ,-'  ,' 
          ||       |  V \ ,|   
          ||       |    |` |   
          ||       |    |   \  
          ||       |    \    \ 
          ||       |     |    \
          ||       |      \_,-'
          ||       |___,,--")_\
          ||         |_|   ccc/
          ||        ccc/       
          ||                

""" +
        " Hello ${world.player.name}, I wish you good luck\n on your journey!\n\n$separationLine\n\n${blue("[SPACE] start the game")}\n";
    return screen;
  }

  @override
  Screen transitionOnInput(KeyCode keyCode, World world) {
    if (keyCode == KeyCode.space) {
      return ExplorationScreen.random();
    }

    return this;
  }
}
