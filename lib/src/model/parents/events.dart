part of raumffisch;


//A class for setting event flags. This is mainly used to trigger sounds in the view.
class EventSystem{
  bool fishdied=false;
  bool shotfired=false;
  bool enemydied=false;
  bool powerupcollected=false;
  bool protectlingsave=false;
  bool shot2fired=false;
  bool shot3fired=false;
  bool startmusic=false;
  bool derhatdochan=false;
  bool gameover=false;
  bool gamestart=true;
  String poweruptype="";
  EventSystem();
  
  resetevents(){
    this.fishdied=false;
    this.shotfired=false;
    this.enemydied=false;
    this.powerupcollected=false;
    this.protectlingsave=false;
    this.shot2fired=false;
    this.shot3fired=false;
    this.startmusic=false;
    this.derhatdochan=false;
    this.gameover=false;
    this.gamestart=false;
    poweruptype="";
  }
}