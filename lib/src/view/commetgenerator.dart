part of raumffisch;

class Commet{
  var xpos;
  var ypos;
  var speed;
  String unitname;
  Commet(this.xpos, this.ypos,this.speed,this.unitname);

}

class Commetgenerator{
  List<Commet> clist;
  Random rand;
  Commetgenerator(int number,int width, int height){
    this.clist=new List<Commet>();
    this.rand=new Random(38993832);
    for(int i=0;i<number;i++){
      clist.add(new Commet(this.rand.nextInt(width),(gamesize*8+this.rand.nextInt(height)),4*(this.rand.nextInt(4)+12),'commet1'));
    }
  }
  void cycle(){
    this.clist.forEach((c){
      
      if(c.ypos>(gamesize*8)){
        if(this.rand.nextInt(1000)==0){
        c.ypos=-50;
        c.xpos=(this.rand.nextInt(gamesize*2*8));
        }
      }
      c.xpos-=c.speed;
      c.ypos+=c.speed;
    });
    
  }
}

class StarGenerator{
  List<Commet> clist;
  Random rand;
  StarGenerator(int number,int width, int height){
    this.clist=new List<Commet>();
    this.rand=new Random(3899383);
    for(int i=0;i<number;i++){
      clist.add(new Commet(this.rand.nextInt(gamesize*8),this.rand.nextInt(height),(this.rand.nextInt(3)+2),'starfield_star'+(this.rand.nextInt(3)+1).toString()));
    }
  }
  void cycle(){
    this.clist.forEach((c){
      
      if(c.xpos<0){
        if(this.rand.nextInt(1400)==0){
        c.ypos=this.rand.nextInt(gamesize*8);
        c.xpos=(gamesize*8);
        }
      }
      c.xpos-=c.speed;
    });
    
  }
}


class FlugscheibenGenerator{
  List<Commet> clist;
  Random rand;
  FlugscheibenGenerator(int number,int width, int height){
    this.clist=new List<Commet>();
    this.rand=new Random(39383);
    for(int i=0;i<number;i++){
      clist.add(new Commet(gamesize*8*2,this.rand.nextInt(height),(this.rand.nextInt(2)+1)+0.4,'reichsflugscheibe'));
    }
  }
  void cycle(){
    this.clist.forEach((c){
      
      if(c.xpos<-200){
        if(this.rand.nextInt(400)==0){
        c.ypos=this.rand.nextInt(gamesize*8);
        c.xpos=(gamesize*8);
        }
      }
      (c.xpos-=c.speed);
      c.ypos+=sin(c.xpos/16)*1.4;
    });
    
  }
}