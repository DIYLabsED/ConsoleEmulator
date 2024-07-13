/*
    Project Azurite
    A configurable console emulator, designed for making videos.
    Uses GraphicsFromFile, a little utility I wrote that allows
    you draw objects on the screen using a config file.
       
    Files used:
    core.json: Contains core configuration, cannot be named something else! 
    This file contains the rest of the filepaths.
    
       
    Written by Adbhut Patil (@OneLabToRuleThemAll)
*/

/*
    Todo:
      clean up this mess
      some way to clear the screen
      animated terminal
*/

// Sys vars
String version;
JSONObject core;
JSONArray messageFile;
PFont terminalFont;
PFont editorFont;
String[] terminalGFFFile;
String[] messages;
color[] messageColors;
int[] messageSizes;
int[] delayBetweenChars;

int[] oldTextX;
int[] oldTextY;

int charIndex = 0, arrayIndex = 0;
int textX = 20, textY = 20;

color defaultTextColor;
int terminalWidth;
int terminalHeight;

final int CONFIRM_CONFIG = 0;
final int TERMINAL = 1;
int scene = CONFIRM_CONFIG;


void setup(){

  size(600, 900);
  arrayIndex = 0;
  charIndex = 0;
  
  textX = 20;
  textY = 20;
      
  // Load config file, and vars from that config file
  loadConfigFile();
       
}


void draw(){
  
  switch(scene){
    
    case CONFIRM_CONFIG:
    displayConfirmConfig();
    break;
    
    case TERMINAL:
    displayTerminal();
    break;
    
    default:
    exit();
    break;
    
  }
      
}


void loadConfigFile(){
  
  core = loadJSONObject("core.json"); 
  
  version = core.getString("version");
  
  terminalFont = createFont(core.getString("messageFont"), core.getInt("fontConversionSize"));
  editorFont = createFont(core.getString("editorFont"), core.getInt("fontConversionSize"));
  
  terminalWidth = core.getInt("terminalWidth");
  terminalHeight = core.getInt("terminalHeight");
  
  terminalGFFFile = gffLoadFile(core.getString("gffFile"));
  
  defaultTextColor = color(core.getInt("defaultTextR"), core.getInt("defaultTextG"), core.getInt("defaultTextB"));
  
  messageFile = loadJSONArray(core.getString("messageFile"));
    
  messages = new String[messageFile.size()];
  messageColors = new color[messageFile.size()];
  messageSizes = new int[messageFile.size()];
  
  oldTextX = new int[messageFile.size()];
  oldTextY = new int[messageFile.size()];
  
  delayBetweenChars = new int[messageFile.size()];
  
  for(int i = 0; i < messageFile.size(); i++){
    
    JSONObject messageJSON = messageFile.getJSONObject(i);
    messages[i] = messageJSON.getString("message");
    messageColors[i] = color(messageJSON.getInt("r"), messageJSON.getInt("g"), messageJSON.getInt("b"));
    messageSizes[i] = messageJSON.getInt("size");
    delayBetweenChars[i] = messageJSON.getInt("delayBetweenChars");
    
  }  
  
}


void displayConfirmConfig(){

  background(0);
  fill(255);
  textFont(editorFont);
  textAlign(CENTER, TOP);
  textSize(50);
  text(version, width/2, 15);
  textSize(30);
  text("\nPress ENTER to start emulation\n(Press TAB to reload configs while emulating!)", width/2, 70);
  
  text("Number of messages loaded: " + messages.length, width/2, 200);
     
}


void keyReleased(){
    
  if(scene == CONFIRM_CONFIG && keyCode == ENTER){
    
    scene = TERMINAL;
   
  }
    
  if(keyCode == TAB){
    
    frameCount = -1;
    
  }
   
}


void displayTerminal(){
 
  textFont(terminalFont);
  
  gffHandleFile(terminalGFFFile);
  
  fill(defaultTextColor);
  stroke(0);
  textSize(20);
  textAlign(CENTER, TOP);
  text(core.getString("creditText") + " | " + version, 300, 880);
  
  textAlign(LEFT, TOP);
  textFont(terminalFont);
  
  String currentString = messages[arrayIndex];
  
  if(charIndex == currentString.length()){
   
    if(arrayIndex < messages.length - 1){
     
      textY += messageSizes[arrayIndex];
      
      arrayIndex++;
      charIndex = 0;
      
    }
    
  }
  else{
   
    charIndex ++;
    
  }
    
  textSize(messageSizes[arrayIndex]);
  fill(messageColors[arrayIndex]);
  text(currentString.substring(0, charIndex), textX, textY);
  
  oldTextX[arrayIndex] = textX;
  oldTextY[arrayIndex] = textY;
  
  if(arrayIndex > 0){
   
    for(int i = 0; i <= arrayIndex - 1; i++){
           
      textSize(messageSizes[i]);
      fill(messageColors[i]);
      text(messages[i], oldTextX[i], oldTextY[i]);
        
    }
    
  }
  
  delay(delayBetweenChars[arrayIndex]);
    
}
