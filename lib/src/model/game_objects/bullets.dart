part of raumffisch;

//Abstract class Bullet to define an interface for bullet objects.
abstract class Bullet extends Movable_Object{
  int _sizex;
  int _sizey;
  int _damage;
  int _speedx;
  int _speedy;
  Bullet(_game,this._speedx,this._speedy) : super(_game);      
  void move();
}

//Class for projectiles extends Movable_Object. 
class Projectile extends Movable_Object implements Bullet{
  int _sizex = 1;
  int _sizey = 1;
  int _damage=1;
  int _speedx;
  int _speedy;
  
  Projectile(_game,this._speedx,this._speedy) : super(_game){
    unitname = "projectile";
    if(this._speedx==0&&this._speedy==0)
      this._speedx=1;
  }
  void move(){
    if(this._speedx>0){
      for(var i=0;i<this._speedx;i++)
        this.moveright();
    }
    else{
      for(var i=0;i<this._speedx.abs();i++)
              this.moveleft();
    }
    
    if(this._speedy>0){
      for(var i=0;i<this._speedy;i++)
        this.movedown();
    }
    else{
      for(var i=0;i<this._speedy.abs();i++)
        this.moveup();
    }
    
  }
}

//Class for a big projectile (bigger + more damage).
class Bigprojectile extends Projectile{
  Bigprojectile(_game,speedx,speedy) : super(_game,speedy,speedy){
    this.unitname="bigprojectile";
    this._sizex=2;
    this._sizey=2;
    this._damage = 3;
  }
}

class SineProjectile0 extends Projectile{
    int _sinecount=0;
  SineProjectile0(_game,speedx,speedy) : super(_game,speedy,speedy){
      this.unitname="bigprojectile";
      this._sizex=2;
      this._sizey=2;
      this._damage = 3;
      this._sinecount=0;
    }
  void move(){
      if(this._speedx>0){
        for(var i=0;i<this._speedx;i++){
          this.moveright_sin(3, 8, true);
        }
        
      }
      else{
        for(var i=0;i<this._speedx.abs();i++){

          this.moveleft(); 
        }
      }
      
      if(this._speedy>0){
        for(var i=0;i<this._speedy;i++){

          this.movedown(); 
        }
      }
      else{
        for(var i=0;i<this._speedy.abs();i++){

          this.moveup();
        }
      }
      this._sinecount++;
    }
  
}

class SineProjectile1 extends SineProjectile0{
  SineProjectile1(_game,speedx,speedy) : super(_game,speedy,speedy){
    
    this.unitname="anotherbigprojectile"; 
  }
  void move(){
        if(this._speedx>0){
          for(var i=0;i<this._speedx;i++){
            this.moveright_sin(3, 8, false);
          }
          
        }
        else{
          for(var i=0;i<this._speedx.abs();i++){

            this.moveleft(); 
          }
        }
        
        if(this._speedy>0){
          for(var i=0;i<this._speedy;i++){

            this.movedown(); 
          }
        }
        else{
          for(var i=0;i<this._speedy.abs();i++){

            this.moveup();
          }
        }
        this._sinecount++;
      }
}


