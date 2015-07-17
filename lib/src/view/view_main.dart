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
  var bgmusic;
  Commetgenerator cgen=new Commetgenerator(10,gamesize*2*8,gamesize*2*8);
  StarGenerator sgen=new StarGenerator(400,gamesize*2*8,gamesize*2*8);
  FlugscheibenGenerator rfsgen = new FlugscheibenGenerator(1,gamesize*2*8,gamesize*2*8);
  //cyclecounters for parrallaxscrolling
  int backgroundscroll=0,mainbackgroundscroll=0;
  
  List<Scrollfont> sfontlist=new List<Scrollfont>();
  var fcounter=0;
  
  HashMap<stxl.Bitmap,String> bitmap_map=new HashMap<stxl.Bitmap,String>();
  var scoredrawer=0;
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
    resMng.addBitmapData('commet1', 'img/commet1.png');
    
    resMng.addBitmapData('starfield_star1', 'img/starfield_star1.png');
    resMng.addBitmapData('starfield_star2', 'img/starfield_star2.png');
    resMng.addBitmapData('starfield_star3', 'img/starfield_star3.png');
    resMng.addBitmapData('reichsflugscheibe', 'img/reichsflugscheibe.png');
    
    resMng.addSound('tripleshot', 'audio/speech/tripleshot.wav');
    resMng.addSound('singleshot', 'audio/speech/singleshot.wav');
    resMng.addSound('spiralshot', 'audio/speech/spiralshot.wav');
    resMng.addSound('doubleshot', 'audio/speech/doubleshot.wav');
    resMng.addSound('gameover', 'audio/speech/gameover.wav');
    resMng.addSound('sushicontrol_online', 'audio/speech/sushicontrol.wav');
    
    resMng.addSound('music1', 'audio/rbr_gamemusic1.ogg');
    
    resMng.addBitmapData('font_space', 'img/font/space.png');
    String fontloader="abcdefghijklmnopqrstuvwxyz";
    for(int i=0;i<fontloader.length;i++){
      resMng.addBitmapData('font_'+fontloader[i], 'img/font/'+fontloader[i]+'.png');
    }
    
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
  void scrollfontDrawer(Scrollfont s){

    for(int i=0;i<s.text.length;i++){
      if(s.x+(i*128)<gamesize*8 && s.x+(i*128)>-128){
        drawBitmapByPixel(s.x+(i*128),s.y+(sin(((i*32)+this.fcounter)/32)*64),'font_'+s.text[i]);
      }
    }
    s.x-=28;
    fcounter+=4;
  }
  
  
  //updates the DOM according to the model
  void update(RaumffischGame model) {
    
    score.setInnerHtml(model._score.toString());
    
    //welcome.style.display = model.stopped ? "block" : "none";
    //Display gameover message
    if(model._gameOver){
    message.innerHtml = "You've died. Your score: "+ model._score.toString();
      
    }
    

    if(model._score-this.scoredrawer>=25){
      this.sfontlist.add(new Scrollfont("quarter",gamesize*8,-64+(gamesize*8)/2));
      this.scoredrawer=model._score;
      
    }
    
    //update background scrolling \o/
    this.backgroundscroll=(this.backgroundscroll+2)%(gamesize*8*2);
    this.mainbackgroundscroll=(this.mainbackgroundscroll+1)%(3840*2).round();    
    
    if(sound_on){
      if(model.eventSystem.startmusic){     
        this.bgmusic=this.resMng.getSound('music1');
                        this.bgmusic.play(true,new stxl.SoundTransform(0.7));
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
        var speech=this.resMng.getSound(model.eventSystem.poweruptype);
          speech.play(false);
          this.sfontlist.add(new Scrollfont(model.eventSystem.poweruptype,gamesize*8,-64+(gamesize*8)/2));
      }
      if(model.eventSystem.gameover){
        var speech=this.resMng.getSound('gameover');
                  speech.play(false);
        
      }
      if(model.eventSystem.gamestart){
        var sound = this.resMng.getSound("sushicontrol_online");
                        sound.play(false);
      }

    }
    
         
    model.eventSystem.resetevents();
    
    this.lifesdisplay.style.width = (model.lifes()*64).toString()+"px";
    this.distancedisplay.style.width = ((model.period / model._level._length)*100).toString()+"%";
    
    this.clearStage();
   
    this.drawBitmapByPixel((-this.mainbackgroundscroll~/4), 0, 'background1');
    for(int i=0;i<this.sfontlist.length;i++){
          this.scrollfontDrawer(this.sfontlist[i]);
          if(this.sfontlist[i].x+(this.sfontlist[i].text.length*128)<-128){
            var dummy=this.sfontlist[i];
            this.sfontlist.remove(dummy);
            print('removed a font');
          }      
    }
    
    rfsgen.cycle();
    cgen.cycle();
    this.drawBitmapByPixel((-this.backgroundscroll~/2), 0, 'background2');
    rfsgen.clist.forEach((c){
                      this.drawBitmapByPixel(c.xpos, c.ypos, c.unitname);
                    });
    this.drawBitmapByPixel((-this.backgroundscroll), 0, 'background3');
    cgen.clist.forEach((c){
          this.drawBitmapByPixel(c.xpos, c.ypos, 'commet1');
        });
    sgen.clist.forEach((c){
              this.drawBitmapByPixel(c.xpos, c.ypos, c.unitname);
            });
   sgen.cycle();
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

class Scrollfont{
  String text;
  var x=gamesize*8;
  var y=200;
  Scrollfont(this.text, this.x,this.y){
    
  } 
}