/*
    GraphicsFromFile 2.0
    Written by Adbhut Patil
    DIY Labs 2024
*/

final char GFF_SPLITCHAR_CMD_ARG = ' '; // Char seperating commands and arguments
final char GFF_SPLITCHAR_ARGS    = ','; // Char seperating arguments

final String GFF_COMMAND_SET_FILL_COL       = "fillcol";
final String GFF_COMMAND_SET_STROKE_COL     = "strokecol";
final String GFF_COMMAND_SET_BACKGROUND_COL = "bgcol";
final String GFF_COMMAND_SET_STROKE_WIDTH   = "strokewidth";
final String GFF_COMMAND_DRAW_RECT          = "rect";
final String GFF_COMMAND_DRAW_ROUND_RECT    = "roundrect";
final String GFF_COMMAND_DRAW_TRIANGLE      = "tri";
final String GFF_COMMAND_DRAW_QUAD          = "quad";
final String GFF_COMMAND_DRAW_ELLIPSE       = "ellipse";


String[] gffLoadFile(String filePath){
  
  String[] file = loadStrings(filePath);
  
  if(file == null){
   
    println("GFXFromFile Error: Not a valid file!");
    while(true);
    
  }
  
    return file;
  
}

void gffHandleFile(String[] gffFile){
 
  for(int i = 0; i < gffFile.length; i++){
    
    String command = split(gffFile[i], GFF_SPLITCHAR_CMD_ARG)[0];
    String arguments = split(gffFile[i], GFF_SPLITCHAR_CMD_ARG)[1];
    
    switch(command){
     
      case GFF_COMMAND_SET_FILL_COL:
      gffHandleSetFillCol(arguments);
      break;
      
      case GFF_COMMAND_SET_STROKE_COL:
      gffHandleSetStrokeCol(arguments);
      break;
      
      case GFF_COMMAND_SET_STROKE_WIDTH:
      gffHandleSetStrokeWidth(arguments);
      break;
      
      case GFF_COMMAND_DRAW_RECT:
      gffHandleDrawRect(arguments);
      break;
      
      case GFF_COMMAND_DRAW_ROUND_RECT:
      gffHandleDrawRoundRect(arguments);
      break;
      
      case GFF_COMMAND_SET_BACKGROUND_COL:
      gffHandleSetBackgroundCol(arguments);
      break;
      
      case GFF_COMMAND_DRAW_TRIANGLE:
      gffHandleDrawTriangle(arguments);
      break;
      
      case GFF_COMMAND_DRAW_QUAD:
      gffHandleDrawQuad(arguments);
      break;
      
      case GFF_COMMAND_DRAW_ELLIPSE:
      gffHandleDrawEllipse(arguments);
      break;
      
      default:
      println("GFXFromFile Error: Cannot parse command!");
      
    }
    
  }
  
}

void gffHandleSetFillCol(String args){
 
  String[] splitArgs = split(args, GFF_SPLITCHAR_ARGS);
  
  int r = int(splitArgs[0]);
  int g = int(splitArgs[1]);
  int b = int(splitArgs[2]);
  int a = int(splitArgs[3]);

  fill(r, g, b, a);
    
}

void gffHandleSetStrokeCol(String args){
  
  String[] splitArgs = split(args, GFF_SPLITCHAR_ARGS);
  
  int r = int(splitArgs[0]);
  int g = int(splitArgs[1]);
  int b = int(splitArgs[2]);
  int a = int(splitArgs[3]);

  stroke(r, g, b, a);
  
}

void gffHandleSetStrokeWidth(String args){

  strokeWeight(int(args));
  
}


void gffHandleDrawRect(String args){
  
  String[] splitArgs = split(args, GFF_SPLITCHAR_ARGS);
  
  int x = int(splitArgs[0]);
  int y = int(splitArgs[1]);
  int w = int(splitArgs[2]);
  int h = int(splitArgs[3]);
  
  rect(x, y, w, h);
  
}

void gffHandleDrawRoundRect(String args){
  
  String[] splitArgs = split(args, GFF_SPLITCHAR_ARGS);
  
  int x = int(splitArgs[0]);
  int y = int(splitArgs[1]);
  int w = int(splitArgs[2]);
  int h = int(splitArgs[3]);
  int r = int(splitArgs[4]);
  
  rect(x, y, w, h, r);
  
}

void gffHandleSetBackgroundCol(String args){

  String[] splitArgs = split(args, GFF_SPLITCHAR_ARGS);
  
  int r = int(splitArgs[0]);
  int g = int(splitArgs[1]);
  int b = int(splitArgs[2]);

  background(r, g, b);
  
}

void gffHandleDrawTriangle(String args){
  
  String[] splitArgs = split(args, GFF_SPLITCHAR_ARGS);
  
  int x1 = int(splitArgs[0]);
  int y1 = int(splitArgs[1]);
  int x2 = int(splitArgs[2]);
  int y2 = int(splitArgs[3]);
  int x3 = int(splitArgs[4]);
  int y3 = int(splitArgs[5]);
  
  triangle(x1, y1, x2, y2, x3, y3);
    
}

void gffHandleDrawQuad(String args){
  
  String[] splitArgs = split(args, GFF_SPLITCHAR_ARGS);
  
  int x1 = int(splitArgs[0]);
  int y1 = int(splitArgs[1]);
  int x2 = int(splitArgs[2]);
  int y2 = int(splitArgs[3]);
  int x3 = int(splitArgs[4]);
  int y3 = int(splitArgs[5]);
  int x4 = int(splitArgs[6]);
  int y4 = int(splitArgs[7]);
  
  quad(x1, y1, x2, y2, x3, y3, x4, y4);
    
}

void gffHandleDrawEllipse(String args){
  
  String[] splitArgs = split(args, GFF_SPLITCHAR_ARGS);
  
  int x = int(splitArgs[0]);
  int y = int(splitArgs[1]);
  int w = int(splitArgs[2]);
  int h = int(splitArgs[3]);
  
  ellipse(x, y, w, h);
  
}
