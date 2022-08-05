import peasy.*;
PeasyCam cam;
JellyCube[][] jellyUniverse = new JellyCube[15][15];
float rot = 0;
float h = 0;
void setup()
{
  cam = new PeasyCam(this, 1000);
  fullScreen(P3D);
  background(0);
  noStroke();
  for (int row = 0; row < jellyUniverse.length; row++)
  {
    for (int col = 0; col < jellyUniverse.length; col++)
    {
      jellyUniverse[row][col] = new JellyCube();
    }
  }
}

void draw()
{
  h+= 0.1;
  background(0);
  spotLight(255,255,255,0,-1500,0,0,1,0,PI,1);
  lights();
  pushMatrix();
  rotateY(rot);
  rot += .005;
  translate((-1100*jellyUniverse.length)/2, 0, -((-1100*jellyUniverse.length)/2));
  for (int row = 0; row < jellyUniverse.length; row++)
  {
    for (int col = 0; col < jellyUniverse.length; col++)
    {
      translate(1100, 0, 0);
      jellyUniverse[row][col].render();
    }
    translate(-1100*jellyUniverse.length, 0, -1100);
  }
  popMatrix();
}

class JellyCube
{
  jellyBox[] jellys = new jellyBox[4];
  int[] xLocs = {-400, -400, 400, 400};
  int[] zLocs = {0, -800, 0, -800};

  public JellyCube()
  {
    for (int i = 0; i < jellys.length; i++)
    {
      jellys[i] = new jellyBox(150, xLocs[i], zLocs[i]);
    }
  }

  void render()
  {
    for (int i = 0; i < jellys.length; i++)
    {
      jellys[i].render();
      jellys[i].bounce();
      jellys[i].move();
    }
  }
}

class jellyBox
{
  float x;
  float y;
  float z;

  float xMover = random(-5, 5);
  float zMover = random(-5, 5);

  float size;
  float w;
  float h;
  float d;

  float vel = 0;
  float velMover = random(.25, .5);
  Boolean goingUp = false;
  float maxY;
  public jellyBox(float size, float x, float z)
  {
    this.x = x;
    this.z = z;
    y = -300;
    maxY = y+15;

    this.size = size;

    w = size;
    h = size;
    d = size;
  }

  void render()
  {

    pushMatrix();
    translate(0, 400, -400);
    fill(255);
    box(1100, 10, 1100);

    fill(255,0,0);
    translate(550, -750, 550);
    box(10, 1500, 10);

    translate(-1100, 0, 0);
    box(10, 1500, 10);

    translate(0, 0, -1100);
    box(10, 1500, 10);

    translate(1100, 0, 0);
    box(10, 1500, 10);
    popMatrix();

    pushMatrix();
    translate(x, y, z);
    fill(h%256, 255, 255);
    box(w, h, d);
    popMatrix();
  }

  void bounce()
  {
    if (goingUp == false)
    {
      y += vel;
      vel += velMover;
    } else
    {
      y -= vel;
      vel -= velMover;
    }

    if (y >= 350 || y <= maxY)
    {
      goingUp =! goingUp;
    }

    if (y >= 250 && goingUp == false)
    {
      h = map(y, 250, 350, size, size/2);
      w = map(y, 250, 350, size, size*1.5);
      d = map(y, 250, 350, size, size*1.5);
    } else if (y >= 250 && goingUp == true)
    {
      h = map(y, 350, 250, size/2, size);
      w = map(y, 350, 250, size*1.5, size);
      d = map(y, 350, 250, size*1.5, size);
    }


    maxY -= 1;
  }

  void move()
  {
    x += xMover;
    z += zMover;

    if (x >= 500 || x <= -500)
    {
      xMover = -xMover;
      zMover = -zMover;
    }
    if (z >= 100 || z <= -900)
    {
      zMover = -zMover;
      xMover = -xMover;
    }
  }
}
