part of raumffisch;

//class to make powerups which are collectible
abstract class Powerup extends Movable_Object {
  Powerup(_game):super(_game){
    this._sizex =3;
    this._sizey =3;
  }
  
  void apply(Ffisch ffisch);
}


class SineDoubleShotPowerup extends Powerup{

  SineDoubleShotPowerup (_game):super(_game){
    this.unitname = "powerupD";
    
  }
  void apply(Ffisch ffisch){
    ffisch._current_weapon = new SineDoubleShot(_game, 6);
    _game.eventSystem.powerupcollected=true;
  }
}


class DoubleShotPowerup extends Powerup{

  DoubleShotPowerup(_game):super(_game){
    this.unitname = "powerup_a_";
    
  }
  void apply(Ffisch ffisch){
    ffisch._current_weapon = new DoubleShot(_game, 8);
    _game.eventSystem.powerupcollected=true;
  }
}


class OneShotPowerup extends Powerup{

  OneShotPowerup(_game):super(_game){
    this.unitname = "powerupC";
    
  }
  void apply(Ffisch ffisch){
    ffisch._current_weapon = new OneShot(_game, 4);
    _game.eventSystem.powerupcollected=true;
  }
}


class DiagonalShotWithFrontPowerup extends Powerup{

  DiagonalShotWithFrontPowerup(_game):super(_game){
    this.unitname = "powerupB";
    
  }
  void apply(Ffisch ffisch){
    ffisch._current_weapon = new DiagonalShotWithFront(_game, 8);
    _game.eventSystem.powerupcollected=true;
  }
}