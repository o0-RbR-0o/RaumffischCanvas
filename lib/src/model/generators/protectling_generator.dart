part of raumffisch;
//Manages lifecycle of protectling and triggers their behaviour

class ProtectlingGenerator extends Generator {
  

  Protectling protectling;
  
  ProtectlingGenerator(Level level, RaumffischGame game) :super(level, game){
    protectling = new Protectling(game);
  }
  void tick (int period){
    if(this.protectling.dead == true){
      this.protectling.setposition((gamesize-1)~/2, gamesize-1-this.protectling._sizey);
      this.protectling.dead = false;
    }
    
    game.ffisch.bullets.forEach((b){
      if(b.detectCollisonWith(this.protectling)){
         this.protectling.die();
      }
    });
    this.protectling.move(period);
    

      if(this.protectling._position_x < 2){
        this.protectling.dead = true;
        game._score+=10;
        game.ffisch.addlifes(1);
      }
    

  }
}