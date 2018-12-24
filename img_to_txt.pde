PImage pic;
int scl;
IntDict charDict;
String[] chars;
int[] charVals;
String[][] total;
void setup() {
  pic = loadImage("heh.png"); //To change the image, change what's in the quotes to the name of the image you want to convert.
  //Make sure that the image is in the same folder as the code, or else it won't work. 
  size(500,450);
  scl = 8; //This is how to control how big the characters are and how focused the image is. With a scl variable of 8-10, the 
  //image will be sort of blurry, but the characters will be very visable. With a scl of 4-6, the image is focused, but it's hard
  //to see that it's actually made up of characters. Mess around with this to find a value that's right for your picture
  total=new String[pic.height/scl][pic.width/scl];
  charDict = new IntDict();
  charDict.set("~",0);
  charDict.set("`",0);
  charDict.set("!",0);
  charDict.set("@",0);
  charDict.set("#",0);
  charDict.set("$",0);
  charDict.set("%",0);
  charDict.set("^",0);
  charDict.set("&",0);
  charDict.set("*",0);
  charDict.set("(",0);
  charDict.set("_",0);
  charDict.set("+",0);
  charDict.set("=",0);
  charDict.set("-",0);
  charDict.set("{",0);
  charDict.set("]",0);
  charDict.set("|",0);
  charDict.set("\\",0);
  charDict.set(";",0);
  charDict.set("\'",0);
  charDict.set("/",0);
  charDict.set(".",0);
  charDict.set(",",0);
  charDict.set(">",0);
  charDict.set("?",0);
  charDict.set(":",0);
  charDict.set("\"",0);
  chars = charDict.keyArray();
  pic.filter(GRAY);
  image(pic,0,0);
  indexChars(chars);
  charDict.sortValues();
  charDict.set(".",255);
  charDict.set("#",0);
  charVals=charDict.valueArray();
  chars=charDict.keyArray();
  averagePix();

}
void draw() {

}

void indexChars(String chars[]) {
  fill(0);
  textSize(scl+2);
  for (int i=0;i<chars.length;i++) {
    background(255);
    text(chars[i],0,7);  
    loadPixels();
    int average=0;
    for (int x=0;x<scl-1;x++) {
      for (int y=0;y<scl-1;y++) {
        int index = (x) + (y) * width;
        color pix=pixels[index];
        average+=red(pix);
      }
    }
    average/=(scl-1)*(scl-1);
    charDict.set(chars[i],average);
    updatePixels();
  }
}


void averagePix() {
  pic.loadPixels();
  for (int y=0;y<pic.height/scl;y++) {
    for (int x=0;x<pic.width/scl;x++) {
      int average=0;
      for (int x2=0;x2<scl;x2++) {
        for (int y2=0;y2<scl;y2++) {
          int index = (x*scl+x2) + (y*scl+y2) * pic.width;
          color pix = pic.pixels[index];
          average+=red(pix);
          average+=blue(pix);
          average+=green(pix);
        }
      }
      average/=scl*scl*2;
      for (int i=0;i<charVals.length-1;i++) {
        if (average>charVals[i]&&average<charVals[i+1]) {
          if (average-charVals[i]>=charVals[i+1]-average) {
            text(chars[i],x*scl+1,y*scl+7);
            total[y][x]=chars[i];
            break;
          }
          else {
            text(chars[i+1],x*scl+1,y*scl+7);
            total[y][x]=chars[i+1];
            break;
          }
        }
      }
    if (total[y][x]==null) total[y][x]=" ";
    }
  }
  pic.updatePixels();
  for (int y=0;y<pic.height/scl;y++) {
    println(total[y]);
  }
}
