part of raumffisch;
//A class for levels
class Level{
  int _powerup_frequency = 1;
  int _enemy_frequency = 1;
  int _length =1;
  int _level = -1;
  var jsonData = null;
  bool levelLoaded=false;
  
  
  
  Level(){
    
  }
  Level.fromVariables(int powerup_frequency, int enemy_frequency, length){
      this._powerup_frequency=powerup_frequency;
      this._enemy_frequency=enemy_frequency;
      this._length=length;
  }
  

  void loaded(var s){
    levelLoaded = true;
  }
  
  

  Level.fromJSONurl(String f){
    String json=r'[{"level": {"length": 700,"enemy_frequency": 60,"powerup_frequency": 2500}},{"level": {    "length": 1450,    "enemy_frequency": 40,    "powerup_frequency": 500}},{"level": {    "length": 2900,    "enemy_frequency": 25,    "powerup_frequency": 600}},{"level": {    "length": 5000,    "enemy_frequency": 10,    "powerup_frequency": 500}}]';
    this.fromJSONstring(json);
  } 
  
  
  void fromJSONstring(String s){
    this.jsonData=JSON.decode(s);
  }

  
  bool levelUp(){
    if(jsonData.length>this._level){
    this._level++;
    print(_level.toString());
    }
    return level(_level);
  }
  bool level(int i){
    if(jsonData.length>i){
    if(jsonData == null || jsonData[i] == null){
      return false;
    }else{

      this._powerup_frequency=jsonData[i]['level']["powerup_frequency"];
      this._enemy_frequency=jsonData[i]['level']["enemy_frequency"];
      this._length=jsonData[i]['level']["length"];
      return true;
    }
    
    }
    
    return true;
  }
}