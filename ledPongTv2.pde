import processing.serial.*;


//
int pal []=new int [128];
int[] cls;
///----------
// The serial port:
Serial myPort;
import gifAnimation.*;
// Number of columns and rows in our system
int cols, rows;


String ledCol;
String ledWallMsg;


PImage[] animation;
Gif loopingGif;
Gif nonLoopingGif;
boolean pause = false;

int flagFrame = 0;
int i=0;
int curFileIndex=0;

String[] files;

void setup() {


  java.io.File folder = new java.io.File(dataPath(""));
  files = folder.list();

  println(files);

  size( 270, 160);
  //  loopingGif = new Gif(this, files[int(random(files.length))]);
  nextImage();
  i++;
  loopingGif.play();


  // Initialize columns and rows
  cols = width/10;
  rows = height/10;

  myPort = new Serial(this, Serial.list()[0], 38400);

  background(255);
}

void draw() {

  background(0);
  fill (0); 

  //stroke(188, 178, 146); 
  if (flagFrame > loopingGif.currentFrame()) {
    flagFrame=0;
    nextImage();
  }
  else {
    flagFrame = loopingGif.currentFrame();
  }

  //println(loopingGif.currentFrame());
  //loopingGif.resize(width, height);
  image(loopingGif, 0, 0, width, height);



  //----------

  //-----------------------------------------------------------------
  //--processing2ledWall
  //-----------------------------------------------------------------

  loadPixels();

  ledWallMsg ="";
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    ledCol = "";
    for (int j = 0; j < rows; j++) {

      // Where are we, pixel-wise?
      int x = i*10;
      int y = j*10;
      // Looking up the appropriate color in the pixel array
      color c = pixels[x+ y*270];
      int value = (int)brightness(c);  // get the brightness
      fill(value);
      //println(hex(value/16,1));

      ledCol += hex(value/16, 1); 
      fill(c);
      stroke(255);
      rect(x, y, 10, 10);

      /*
      if (fort) {
       byteFort=value;
       byteFort = byteFort << 4;
       byteFort = byteFort&0xF0;
       
       } else {
       
       byteFaible=char(value/16);
       byteFaible=byteFaible&0x0F;
       buffer=(byteFort&byteFaible);
       message[t]=buffer;
       fort=true;
       t++;
       bitFort=0;
       }*/
    }
    ledWallMsg += ledCol;
    updatePixels();
  }
  //send pix to the Led Wall
  //println(ledWallMsg);
  //println("Z"+ledWallMsg);
  // myPort.write("");
  myPort.write("Z"+ledWallMsg);
  //  delay(100);
}

void nextImage() {
  //    if (curFileIndex == files.length){
  //     curFileIndex=0;
  //    }
  //    println(files[curFileIndex]);
  //    loopingGif = new Gif(this, files[curFileIndex]);
  //     curFileIndex++;

  String fileName = files[int(random(files.length))];
  println(fileName);
  //loopingGif.stop();
  if (loopingGif != null) loopingGif.dispose();
  loopingGif = new Gif(this, fileName);
  ;
  //loopingGif = new Gif(this, fileName);
  loopingGif.loop();

  i++;
  println(i);
  //println (Runtime.getRuntime().freeMemory());
}

