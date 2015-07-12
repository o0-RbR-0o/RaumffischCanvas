part of raumffisch;

/**
 * A [GameView] object interacts with the DOM tree
 * to reflect actual [RaumffischGame] state to the user.
 */
class GameView {

  List<List<Element>> gamefield;
  final bool sound_on=true;
  //This will show the players score
  final HtmlElement score = querySelector("#score");  
  
  //introvoerlay for the welcomescreen
  final HtmlElement intro_overlay = querySelector("#intro_overlay");
 

  /**
   * Element with id '#snakegame' of the DOM tree.
   * Used to visualize the field of a [RaumffischGame] as a HTML table.
   */
  final HtmlElement game = querySelector('#snakegame');
  
  /**
   * Element to display ffischlifes
   * 
   */
  final HtmlElement lifesdisplay = querySelector('#ffischlifes');
  final HtmlElement distancedisplay = querySelector('#distance');

  
  final HtmlElement sbg = querySelector('#snakegame');
  final HtmlElement sbg2 = querySelector('#scrollbg');
  final HtmlElement mbg = querySelector('#main_background');
  /**
   * Element with id '#gameover' of the DOM tree.
   * Used to indicate that a game is over.
   */
  final gameover = querySelector('#gameover');
  
  final Element message = querySelector('#message');
  
  var canvas=querySelector('#stage');
  stxl.Stage stage;
  stxl.RenderLoop renderLoop;
  stxl.ResourceManager resMng=new stxl.ResourceManager();

  /**
   * Start button of the game.
   */
  HtmlElement get startButton => querySelector('#intro_overlay');
  
  //cyclecounters for parrallaxscrolling
  int backgroundscroll=0,mainbackgroundscroll=0;

  void loadAssets(){
    
    //Sounds
    resMng.addSound("shot1", "audio/laser.wav");
    resMng.addSound("shot2", "audio/laser2.wav");
    resMng.addSound("shot3", "audio/laser3.wav");
    resMng.addSound("powerup1", "audio/powerup1.wav");
    resMng.addSound("enemydie1", "audio/enemydie1.wav");
    
    //Graphics
    resMng.addBitmapData('enemykraken', 'img/kraken.gif');
    resMng.addBitmapData('bigprojectile', 'img/bigbullet.gif');
    resMng.addBitmapData('anotherbigprojectile', 'img/bigbullet_offset2.gif');
    resMng.addBitmapData('projectile', 'img/bullet.gif');
    resMng.addBitmapData('neuffisch', 'img/raumffisch_sprite.png');
    resMng.addBitmapData('powerup_a_', 'img/powerup1.gif');
    resMng.addBitmapData('powerupB', 'img/powerup2.gif');
    resMng.addBitmapData('powerupC', 'img/powerup3.gif');
    resMng.addBitmapData('powerupD', 'img/powerup4.gif');
    resMng.addBitmapData('protectling', 'img/stichling.png');
    resMng.addBitmapData('protectling2', 'img/stichling2.png');
    resMng.addBitmapData('background1', 'img/space.jpg');
    resMng.addBitmapData('background2', 'img/starfield.png');
    resMng.addBitmapData('background3', 'img/starfield2.png');
  }
  
  GameView(){
    this.stage=new stxl.Stage(this.canvas);
    this.renderLoop=new stxl.RenderLoop();
    this.renderLoop.addStage(this.stage);
    
    this.stage.refreshCache();

    
    
  }
  void drawBitmap(x,y,String name){
    var tBitmap=new stxl.Bitmap(resMng.getBitmapData(name));
        tBitmap.x=x*8;
        tBitmap.y=y*8;
        this.stage.addChild(tBitmap);
    
  }
  void drawBitmapByPixel(x,y,String name){
      var tBitmap=new stxl.Bitmap(resMng.getBitmapData(name));
          tBitmap.x=x;
          tBitmap.y=y;
          this.stage.addChild(tBitmap);
      
    }
  void clearStage(){
    while(this.stage.children.length!=0){
      this.stage.children.clear();
    }
    
  }
  //updates the DOM according to the model
  void update(RaumffischGame model) {
    
    score.setInnerHtml(model._score.toString());
    
    //welcome.style.display = model.stopped ? "block" : "none";
    //Display gameover message
    if(model._gameOver){
    message.innerHtml = "You've died. Your score: "+ model._score.toString();
      
    }
    


    
    //update background scrolling \o/
    this.backgroundscroll=(this.backgroundscroll+2)%(gamesize*8*2);
    this.mainbackgroundscroll=(this.mainbackgroundscroll+1)%(3840*2).round();    
    
    if(sound_on){
      if(model.eventSystem.startmusic){     
                        stxl.AudioElementSound.load("audio/rbr_gamemusic1.ogg").then((stxl.Sound sound){sound.play(true,new stxl.SoundTransform(0.5));});
      }
      if(model.eventSystem.shotfired){
        var sound = this.resMng.getSound("shot1");
        sound.play(false);
      }
      if(model.eventSystem.shot2fired){
        var sound = this.resMng.getSound("shot2");
                sound.play(false);
      }
      if(model.eventSystem.shot3fired){
        var sound = this.resMng.getSound("shot3");
                sound.play(false);
      }
      if(model.eventSystem.enemydied){
        var sound = this.resMng.getSound("enemydie1");
                sound.play(false);
      }
      if(model.eventSystem.powerupcollected){
        var sound = this.resMng.getSound("powerup1");
                sound.play(false);
      }

    }
    
         
    model.eventSystem.resetevents();
    
    this.lifesdisplay.style.width = (model.lifes()*64).toString()+"px";
    this.distancedisplay.style.width = ((model.period / model._level._length)*100).toString()+"%";
    this.clearStage();
    this.drawBitmapByPixel((-this.mainbackgroundscroll~/4), 0, 'background1');
    this.drawBitmapByPixel((-this.backgroundscroll~/2), 0, 'background2');
    this.drawBitmapByPixel((-this.backgroundscroll), 0, 'background3');
   
    //Draws on the gamefiels accroding to model
   // gamefield.forEach((f){f.forEach((td){td.classes.clear();});});
    model.objects.forEach(
      (o){
        if(!o.dead){
          if(resMng.containsBitmapData(o.unitname))
          this.drawBitmap(o._position_x, o._position_y,o.unitname);
        }
      }
    );
    
  }



}