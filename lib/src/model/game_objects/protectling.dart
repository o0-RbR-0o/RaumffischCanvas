part of raumffisch;
//Ffisch has to protect this small fellow to get more points and lifes.
class Protectling extends Movable_Object{
  int _sizex = 1;
  int _sizey = 2;
  bool dead = false;
  int dir =1;
  
  Protectling(_game) : super(_game){
    unitname = "protectling";
  }
  
  void die(){
    super.die();
    _game._score -5;
    //_game._ffisch.removelifes(1);
  }
  
  move(int period){

    if(_position_y==gamesize-_sizey-1){
      moveup();
      moveleft();
      moveleft();
      moveleft();
      dir=-1;
    }
    
    if(_position_y-_sizey == 0){
      movedown();
      moveleft();
      moveleft();
      moveleft();
      dir = 1;
      this.unitname="protectling2";
    }
    
    
    if(period % 2 == 0){
      this._position_y+=dir;

    }
  }
}