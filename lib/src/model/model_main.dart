part of raumffisch;

/**
 * Defines a [RaumffischGame]. A [RaumffischGame] consists of n x n field.
 */
class RaumffischGame {


  List<Movable_Object> _objects = new List<Movable_Object>();
  Ffisch ffisch;
  Protectling protectling;
  int _score = 0;
  
  int period = 0;
  
  Level _level;
  
  EnemyGenerator _enemyGenerator;
  ProtectlingGenerator _protectlingGenerator;
  PowerupGenerator _powerupGenerator;


  EventSystem eventSystem=new EventSystem();



  // The field size of the game (nxn field)
  final int _size;

  // The gamestate of the game (one of #running, #stopped).
  Symbol _gamestate;
  

  /**
   * Indicates whether game is stopped.
   */
  bool get stopped => _gamestate == #stopped;

  /**
   * Indicates whether game is running.
   */
  bool get running => _gamestate == #running;
  

  /**
   * Starts the game.
   */
  void start() { _gamestate = #running; }

  /**
   * Stops the game.
   */
  void stop() { _gamestate = #stopped; }

  

  //returns the lifes of the ffisch
  int lifes(){
    return ffisch._lifes;
  }

  //Constructor
  RaumffischGame(this._size) {
    start();
    
    _level = new Level.fromJSONurl("levels/level.json");

    ffisch = new Ffisch(this,new OneShot(this, 16));


    _enemyGenerator = new EnemyGenerator(_level, this);
    _protectlingGenerator = new ProtectlingGenerator(_level, this);
    _powerupGenerator = new PowerupGenerator(_level, this);
    _protectlingGenerator.protectling.setposition((gamesize-1)~/2, gamesize-1-_protectlingGenerator.protectling._sizey);
    stop();
  }
  

  

  /**
   * Returns whether the game is over.
   * GGame is over if Ffisch has no more lifes
   */
  bool get gameOver => _gameOver;  
  bool _gameOver = false;


  List<Movable_Object> get objects {
    
    _objects.clear();
    _objects.add(_protectlingGenerator.protectling);
    _objects.add(ffisch);
    _objects.addAll(_enemyGenerator.enemies);
    _objects.addAll(ffisch.bullets);
    _objects.addAll(_powerupGenerator._powerups);
   
    return _objects;
  }
  
  //Switches the Level to the next level.
  void applylevelUp(){
    _level.levelUp();
      
    
  }
  
  //updates the model according to game logic
  void update(int period) {
    this.period = period;
    if (running){
      if(period > _level._length){
        applylevelUp();
      }
      _enemyGenerator.tick(period);
      _protectlingGenerator.tick(period);
      _powerupGenerator.tick(period);
    }
    if(ffisch._lifes <=0){
      this._gameOver = true;
      
    }
  }
  int get size => _size;
  int get level => 1;

}