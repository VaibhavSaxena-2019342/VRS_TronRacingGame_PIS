
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

int time;
int wait = 60000;

class obstacle1
{
  int speed,yl;
  float xl;
  int guardb=0;
  
  obstacle1(int spt)
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

obstacle1 obs1[];

void setup()
{
  fullScreen(P3D);
  bw=width/2+300;
  bh=800;
  ow=width/2-300;
  oh=800;
  
  obs1 = new obstacle1[obsnumber];
  
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
    obs1[i] = new obstacle1(10);
  }
}

void serialEvent (Serial myPort)
{
  x = myPort.readStringUntil('\n'); 
}

void draw()
{      
  bluel=bw-35;
  bluer=bw+35;  
  
  if(x.charAt(0)=='2')
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

  if(jk==0)
  {
    time = millis();
    gamemusic.play();
    jk=1;
  }
  background(0);
  imageMode(CENTER);
  image(samname,width/2+780,300,280,50);
  
  textSize(60);
  strokeWeight(5);
  fill(255,165,0);
  textAlign(CENTER);
  text(60-((millis()-time)/1000),width/2-800,500);
  
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

  if(m2!=0)
  {
    bw=bw+(2*m2);
  }
  
  pot2 = pot2/5;
  
  bh = 800 - (4*pot2);

  bluel=bw-35;
  bluer=bw+35;  
  
  for(int i=0;i<obsnumber;i++)
  {
    obs1[i].run();
  }
  
  strokeWeight(8);
  
  stroke(0,255,255);
  line(bw+1,bh+70,bw+1,height);
  
  imageMode(CENTER);
  
  image(blue,bw,bh,75,180);
  
  strokeWeight(15);
  stroke(0,255,255);
  line(width/2-600,-20,width/2-600,height+20);
  line(width/2+600,-20,width/2+600,height+20);
  
  if(blife==0)
  {
    screen=25;
  }
  else if(millis() - time >= wait)
  {
    screen=27;
  }
}
