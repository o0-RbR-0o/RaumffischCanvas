part of raumffisch;

//Class for the player Ffisch extends Movable_Object. Would be cool to change positioning stuff to use vectors...
class Ffisch extends Movable_Object{
  int _powerups;
  int _lifes = 3;
  int _sizex = 8;
  int _sizey = 6;
  Weapon _current_weapon;
  
  List<Bullet> bullets = new List<Bullet>();
  
  Ffisch(_game,this._current_weapon):super(_game){
    unitname = "neuffisch";
    
    final s = _game.size;
     this._position_y =  s ~/2;
     this._position_x = 2;
  }
  
  //Adds "anzahl" lifes to the Ffisch
  void addlifes(int anzahl){
    this._lifes=this._lifes+anzahl<=5?this._lifes+anzahl:5;
  }
  
  //Removes "anzahl" lifes from the Ffisch
  void removelifes(int anzahl){
    this._lifes-=anzahl;
  }
  
  //Sets the amount of lifes for the Ffisch
  void setlifes(int anzahl){
    this._lifes=anzahl;
  }
  
  //Adds "anzahl" powerups to the Ffisch
  void addpowerups(int anzahl){
    this._powerups+=anzahl;
  }
  
  //Removes "anzahl" powerups from the Ffisch
  void removepowerups(int anzahl){
    this._powerups-=anzahl;
  }
  
  
  void shoot(){
    this.bullets.addAll(this._current_weapon.shoot());
  }
}