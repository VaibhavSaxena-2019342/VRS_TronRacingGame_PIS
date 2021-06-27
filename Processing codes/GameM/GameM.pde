
import processing.sound.*;
import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort1,myPort2;
String x,x1,x2;
float pitch1,pot1,pitch2,pot2;
int screen;
PImage rinname,samname;
float xp,yp;
int radius=15,obsnumber=3;

int m1=0,m2=0;
int olife=3,blife=3;
float bw,bh,ow,oh;
float orangel,oranger,bluel,bluer;
int jk=0;
PImage blue,orange;
SoundFile gamemusic;

class obstacle
{
  int speed,yl;
  float xl;
  int guardo=0,guardb=0;
  
  obstacle(int spt)
  {
    speed=spt;
    respawn();
  }
  
  void move()
  {
    yl+=speed;
  }
  
  void respawn()
  {
    yl=-int(random(0,height));
    xl=int(random(width/2-500,width/2+400));
  }
  
  void collide()
  {
    if(guardo==0)
    {
      if(abs(ow-xl)<170 && abs(oh-yl)<100)
      {
        olife--;
        guardo=1;
      }
    }
    if(guardb==0)
    {
      if(abs(bw-xl)<170 && abs(bh-yl)<100)
      {
        blife--;
        guardb=1;
      }
    }
  }
  
  void teleport()
  {
    if(yl>height+radius)
    {
      guardo=0;
      guardb=0;
      respawn();
    }
  }
  
  void display()
  {
    noStroke();
    fill(255,165,0);
    rect(xl,yl,150,20);
  }
  
  void run()
  {
    collide();
    move();
    display();
    teleport();
  }
}

obstacle obs[];

void setup()
{
  fullScreen(P3D);
  bw=width/2+300;
  bh=800;
  ow=width/2-300;
  oh=800;
  
  obs = new obstacle[obsnumber];
  
  background(0);
  noStroke();
  
  blue = loadImage("bikeblue.png");
  orange = loadImage("bikeorange.png");
  rinname = loadImage("rinname.PNG");
  samname = loadImage("samname.PNG");
  
  gamemusic = new SoundFile(this,"game.mp3");
  
  
  myPort1 = new Serial(this, "COM5", 9600); 
  myPort1.bufferUntil('\n'); 
  myPort2 = new Serial(this, "COM8", 9600); 
  myPort2.bufferUntil('\n');  
  
  for(int i=0;i<obsnumber;i++)
  {
    obs[i] = new obstacle(10);
  }
}

void serialEvent (Serial myPort)
{
  x = myPort.readStringUntil('\n'); 
}

void draw()
{      
  orangel=ow-35;
  oranger=ow+35;
  bluel=bw-35;
  bluer=bw+35;  
  
  if(x.charAt(0)=='1')
  {
    x1=x;
    if(x1!=null)
    {
      String pre[]=split(x1,"#");
      String items[]=split(pre[1],"+");
      pitch1=float(items[0]);
      pot1=float(items[1]);
    }
  }
  else if(x.charAt(0)=='2')
  {
    x2=x;
    if(x2!=null)
    {
      String pre[]=split(x2,"#");
      String items[]=split(pre[1],"+");
      pitch2=float(items[0]);
      pot2=float(items[1]);
    }
  }
  println(pitch1);
  println(pitch2);
  println(pot1);
  println(pot2); 

  if(jk==0)
  {
    gamemusic.play();
    jk=1;
  }
  background(0);
  imageMode(CENTER);
  image(rinname,width/2-780,300,200,50);
  image(samname,width/2+780,300,280,50);
  
  if(olife==3)
  {
    stroke(255,165,0);
    fill(0);
    strokeWeight(2);
    ellipse(width/2-780,height/2-100,70,70);  
    strokeWeight(4);
    ellipse(width/2-780,height/2-100,100,100); 
    fill(255,165,0);
    strokeWeight(5);
    ellipse(width/2-780,height/2-100,40,40);
    
    stroke(0);
    fill(0);
    strokeWeight(10);
    line(width/2-780,height/2-100,width/2-780,height/2-30);
  }
  else if(olife==2)
  {
    stroke(255,165,0);
    fill(0);
    strokeWeight(2);
    ellipse(width/2-780,height/2-100,70,70);   
    fill(255,165,0);
    strokeWeight(5);
    ellipse(width/2-780,height/2-100,40,40); 
    
    stroke(0);
    fill(0);
    strokeWeight(10);
    line(width/2-780,height/2-100,width/2-780,height/2-30);
  }
  else if(olife==1)
  {
    stroke(255,165,0);
    strokeWeight(5);
    fill(255,165,0);
    ellipse(width/2-780,height/2-100,40,40);
    
    stroke(0);
    fill(0);
    strokeWeight(10);
    line(width/2-780,height/2-100,width/2-780,height/2-30);
  }
  if(blife==3)
  {
    stroke(0,255,255);
    fill(0);
    strokeWeight(2);
    ellipse(width/2+780,height/2-100,70,70);  
    strokeWeight(4);
    ellipse(width/2+780,height/2-100,100,100); 
    fill(0,255,255);
    strokeWeight(5);
    ellipse(width/2+780,height/2-100,40,40);
    
    stroke(0);
    fill(0);
    strokeWeight(10);
    line(width/2+780,height/2-100,width/2+780,height/2-30);
  }
  else if(blife==2)
  {
    stroke(0,255,255);
    fill(0);
    strokeWeight(2);
    ellipse(width/2+780,height/2-100,70,70);   
    fill(0,255,255);
    strokeWeight(5);
    ellipse(width/2+780,height/2-100,40,40); 
    
    stroke(0);
    fill(0);
    strokeWeight(10);
    line(width/2+780,height/2-100,width/2+780,height/2-30);
  }
  else if(blife==1)
  {
    stroke(0,255,255);
    strokeWeight(5);
    fill(0,255,255);
    ellipse(width/2+780,height/2-100,40,40);
    
    stroke(0);
    fill(0);
    strokeWeight(10);
    line(width/2+780,height/2-100,width/2+780,height/2-30);
  }
    
  
  if(pitch1<-10&&pitch1>-30)
  {
    m1=-1;
  }
  else if(pitch1<-30)
  {
    m1=-2;
  }
  else if(pitch1>10&&pitch1<30)
  {
    m1=1;
  }
  else if(pitch1>30)
  {
    m1=2;
  }
  else 
  {
    m1=0;
  }
  
  if(pitch2<-10&&pitch2>-30)
  {
    m2=-1;
  }
  else if(pitch2<-30)
  {
    m2=-2;
  }
  else if(pitch2>10&&pitch2<30)
  {
    m2=1;
  }
  else if(pitch2>30)
  {
    m2=2;
  }
  else 
  {
    m2=0;
  }
  
  if(orangel<=width/2-595)
  {
    if(m1==-1)
    {
      m1=1;
    }
    else if(m1==-2)
    {
      m1=2;
    }
  }
  
  if(bluel<=width/2-595)
  {
    if(m2==-1)
    {
      m2=1;
    }
    else if(m2==-2)
    {
      m2=2;
    }
  }
  
  if(oranger>=width/2+595)
  {
    if(m1==1)
    {
      m1=-1;
    }
    else if(m1==2)
    {
      m1=-2;
    }
  }
  
  if(bluer>=width/2+595)
  {
    if(m2==1)
    {
      m2=-1;
    }
    else if(m2==2)
    {
      m2=-2;
    }
  }
  
  if(oranger>=bluel&&oranger<bluer)
  {
    m1=-2;
    m2=2;
  }
  else if(bluer>=orangel&&bluer<oranger)
  {
    m1=2;
    m2=-2;
  }
 
  if(m1!=0)
  {
    ow=ow+(2*m1);
  }
  if(m2!=0)
  {
    bw=bw+(2*m2);
  }
  
  pot1 = pot1/5;
  pot2 = pot2/5;
  
  oh = 800 - (4*pot1);
  bh = 800 - (4*pot2);

  orangel=ow-35;
  oranger=ow+35;
  bluel=bw-35;
  bluer=bw+35;  
  
  for(int i=0;i<obsnumber;i++)
  {
    obs[i].run();
  }
  
  strokeWeight(8);
  
  stroke(0,255,255);
  line(bw+1,bh+70,bw+1,height);
  
  stroke(255,165,0);
  line(ow+1,oh+70,ow+1,height);
  
  imageMode(CENTER);
  
  image(blue,bw,bh,75,180);
  image(orange,ow,oh,75,180);
  
  strokeWeight(15);
  stroke(0,255,255);
  line(width/2-600,-20,width/2-600,height+20);
  line(width/2+600,-20,width/2+600,height+20);
  
  if(olife<1)
  {
    screen=27;
  }
  else if(blife<1)
  {
    screen=25;
  }
}
