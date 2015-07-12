part of raumffisch;

//base class for generators which manages the lifecycle of it's objects
//and and triggers their behaviour
//Todo:

//improve seed;
abstract class Generator{
  RaumffischGame game;
  Random _random = new Random(872739419772238);
  Level _level;
  Generator(Level level, RaumffischGame game){
    this.game = game;
    this._level = level;
  }
  //for behaviours triggering
  //int period ist the current cycle count of the controller.
  void tick(int period);
}