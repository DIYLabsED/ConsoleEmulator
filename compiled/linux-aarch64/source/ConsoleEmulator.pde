import java.awt.Desktop;
import java.net.URI;
import java.io.IOException;
import java.net.URISyntaxException;

Desktop desktop = Desktop.getDesktop();

final int SCENE_HOME = 0;
final int SCENE_THEME = 1;
final int SCENE_LANGUAGE = 2;
final int SCENE_PROJECT_SELECT = 3;
final int SCENE_SETTINGS = 4;
final int SCENE_INTRO_PREQUEL = 5;
final int SCENE_INTRO_TUTORIAL = 6;
int scene = SCENE_HOME;

boolean showTutorial;

PImage consoleEmulatorLogo;

boolean isMouseReleased = false;
int mouseReleasedX;
int mouseReleasedY;


JSONObject coreConfig;
JSONObject saveFile;


UIButton themeMenuBack;
UIButton settingsMenuBack;
UIButton languageMenuBack;
UIButton homeMenuExit;
UIButton settingsMenuTheme;
UIButton settingsMenuFactoryReset;
UIButton settingsMenuLanguage;
UIButton homeMenuEditor;
UIButton homeMenuProject;
UIButton homeMenuSettings;
UIButton projectMenuBack;
UIButton homeMenuDocumentation;
UIButton introMenuNext;


void setup(){
  
  coreConfig = loadJSONObject("internal/core.json");
  saveFile = loadJSONObject("internal/save.json");
  
  loadDataFromSave();
  
  PImage icon = loadImage(coreConfig.getString("iconFilepath"));
  surface.setIcon(icon);
  surface.setTitle("ConsoleEmulator " + coreConfig.getString("versionString") + "    |    DIY Labs 2024");
  
  
  if(coreConfig == null){
   super.exit(); 
  }
  
  consoleEmulatorLogo = loadImage(coreConfig.getString("logoFilepath"));
  consoleEmulatorLogo.resize(900, 0);
  
  if(!localisationInit()){
    exit();
  }

  if(!themeInit()){
    exit();
  }
    
  loadUIElements();
  
  size(900, 500);
    
}

void draw(){
   
  background(THEME_BACKGROUND_COL);
  
  switch(scene){
   
    case SCENE_HOME:
      homePage();
    break;
    
    case SCENE_THEME:
      themeSelector();
    break;
    
    case SCENE_LANGUAGE:
      languageSelector();
    break;
    
    case SCENE_PROJECT_SELECT:
      projectSelector();
    break;
    
    case SCENE_SETTINGS:
      settingsPage();
    break;
      
    case SCENE_INTRO_PREQUEL:
      introPrequel();
    break;

    case SCENE_INTRO_TUTORIAL:
      intro();
    break;
      
    default:
      errorPageScene();
    break;
    
  }
  
  
}

void mouseReleased(){
  
  isMouseReleased = true;
  mouseReleasedX = mouseX;;
  mouseReleasedY = mouseY;
  
}


void keyReleased(){
   
  if(scene == SCENE_THEME){
      
    if(keyCode == UP){
      
      handleThemeDecrement();
      
    }
    
    if(keyCode == DOWN){
      
      handleThemeIncrement();

    }
    
  }
  
  if(scene == SCENE_LANGUAGE || scene == SCENE_INTRO_PREQUEL){
      
    if(keyCode == UP){
      
      handleLanguageDecrement();
      
    }
    
    if(keyCode == DOWN){
      
      handleLanguageIncrement();

    }
    
  }
  
  if(keyCode == TAB){
   
    frameCount = -1;
    
  }

  if(key == DELETE){
    
    logDebugInfo();
    
  }
  
  if(scene == SCENE_INTRO_TUTORIAL){
   
    scene = SCENE_HOME;
    
  }

}

void loadUIElements(){
  
  int y = 120;
  int inc = 55;

  themeMenuBack            = new UIButton(140, 30, 5, 5, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_BACK"));
  languageMenuBack         = new UIButton(140, 30, 5, 5, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_BACK"));
  projectMenuBack          = new UIButton(140, 30, 5, 5, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_BACK"));
  settingsMenuBack         = new UIButton(140, 30, 5, 5, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_BACK"));

  homeMenuEditor           = new UIButton(350, 45, UI_BUTTON_CENTER, y, 2, THEME_BACKGROUND_COL, THEME_BACKGROUND_COL, THEME_UNAVAILABLE_COL, THEME_UNAVAILABLE_COL, THEME_UNAVAILABLE_COL, THEME_UNAVAILABLE_COL, localisation.getString("UI_BUTTON_EDITOR"));
  y += inc;
  homeMenuProject          = new UIButton(350, 45, UI_BUTTON_CENTER, y, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_PROJECTS"));
  y += inc;
  homeMenuDocumentation    = new UIButton(350, 45, UI_BUTTON_CENTER, y, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_DOCUMENTATION"));
  homeMenuSettings         = new UIButton(350, 45, UI_BUTTON_CENTER, 325, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_SETTINGS"));  
  homeMenuExit             = new UIButton(350, 45, UI_BUTTON_CENTER, height - 80, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_EXIT"));
  
  y = 100;
  inc = 55;

  settingsMenuTheme        = new UIButton(350, 45, UI_BUTTON_CENTER, y, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_THEMES"));
  y += inc;
  settingsMenuLanguage     = new UIButton(350, 45, UI_BUTTON_CENTER, y, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_LANGUAGES"));

  settingsMenuFactoryReset = new UIButton(350, 30, UI_BUTTON_CENTER, height - 35, 2, THEME_BACKGROUND_COL, THEME_ERROR_MAJOR_COL, THEME_ERROR_MAJOR_COL, THEME_ERROR_MAJOR_COL, THEME_ERROR_MAJOR_COL, THEME_ERROR_MAJOR_COL, localisation.getString("UI_BUTTON_FACRESET"));

  introMenuNext            = new UIButton(350, 45, UI_BUTTON_CENTER, height - 80, 2, THEME_BACKGROUND_COL, THEME_HIGHLIGHT_COL, THEME_HIGHLIGHT_COL, THEME_FOREGROUND_COL, THEME_FOREGROUND_COL, THEME_BACKGROUND_COL, localisation.getString("UI_BUTTON_NEXT"));
 

}

void errorPageScene(){
 
  fill(255, 0, 0);
  strokeWeight(0);
  background(0);
  
  textAlign(CENTER, CENTER);
  textSize(50);
  
  text(localisation.getString("UI_SCENE_ILLEGAL"), width/2, height/2);
  
}

void homePage(){
 
  if(homeMenuExit.handle()){
    safeExit();   
  }
     
  if(homeMenuProject.handle()){
   scene = SCENE_PROJECT_SELECT; 
  }
  
  if(homeMenuDocumentation.handle()){
   openWebPage("https://github.com/DIYLabsED/ConsoleEmulator/wiki"); 
  }

  if(homeMenuSettings.handle()){
   scene = SCENE_SETTINGS; 
  }

  homeMenuEditor.handle();
  
  image(consoleEmulatorLogo, 0, 0);
  tint(THEME_HIGHLIGHT_COL);
  
  fill(THEME_FOREGROUND_COL);
  strokeWeight(0);
  textSize(14);
  textAlign(LEFT, BOTTOM);
  text("ConsoleEmulator " + coreConfig.getString("versionString"), 2, height - 2);
  textAlign(RIGHT, BOTTOM);
  text(coreConfig.getString("githubRepo"), width - 2, height - 2);
  
}

void settingsPage(){
  
  fill(THEME_FOREGROUND_COL);
  strokeWeight(0);
      
  textSize(40);
  textAlign(CENTER, TOP);
  text(localisation.getString("UI_SCENE_SETTINGS"), width/2, 10);
  
  if(settingsMenuBack.handle()){
    scene = SCENE_HOME;   
  }
  if(settingsMenuTheme.handle()){
    scene = SCENE_THEME;  
  }
  
  if(settingsMenuLanguage.handle()){
    scene = SCENE_LANGUAGE;  
  }
  
  if(settingsMenuFactoryReset.handle()){
   
    factoryReset();
    
  }

}

// prevent window from closing when escape key is pressed
// to close sketch, super.exit() is used
void exit(){
    
}

void openWebPage(String siteUrl) {
  
  try {
    URI site = new URI(siteUrl);
    if (Desktop.isDesktopSupported() && desktop.isSupported(Desktop.Action.BROWSE)) {
      desktop.browse(site);
    } else {
      println("Desktop does not support browse");
    }
  } catch(URISyntaxException e) {
    e.printStackTrace();
  } catch(IOException e) {
    e.printStackTrace();
  }
  
}

void loadDataFromSave(){
 
  selectedTheme = saveFile.getInt("theme");  
  selectedLanguage = saveFile.getInt("language");
  showTutorial = saveFile.getBoolean("showTutorial");
  
  if(showTutorial){
   scene = SCENE_INTRO_PREQUEL; 
  }
  
}

void saveDataToSave(){

  JSONObject temp = new JSONObject();
  
  temp.setInt("theme", selectedTheme);
  temp.setInt("language", selectedLanguage);
  temp.setBoolean("showTutorial", false);
  
  saveJSONObject(temp, coreConfig.getString("saveFileFilePath"));
    
}

void logDebugInfo(){
  
  // Layout of log:
  // Date | Time (YYYYMMDD | HHMMSS
  // Sketch file path
  // CE Version
  // OS name
  // OS arch
  // Java vendor name
  // Processor identifier
  
  String filePath = sketchPath(coreConfig.getString("mainLogFilePathAppend"));
  String[] log = new String[8];
  
  log[0] = "THIS LOG MAY CONTAIN PERSONAL INFORMATION. DO NOT SHARE IT UNLESS YOU TRUST THE RECIPIENT!\n";
  log[1] = "Date | Time: " + str(year()) + str(month()) + str(day()) + "  |  " + str(hour()) + ":" + str(minute()) + ":" + str(second());
  log[2] = "CE filepath: " + sketchPath();
  log[3] = "CE version: " + coreConfig.getString("versionString");
  log[4] = "OS name: " + System.getProperty("os.name");
  log[5] = "OS architecture: " + System.getProperty("os.arch");
  log[6] = "Java vendor name: " + System.getProperty("java.vendor");
  log[7] = "Processor identifier: " + System.getenv("PROCESSOR_IDENTIFIER");
  
  saveStrings(filePath, log);
  
  background(255);
  
}

void intro(){
 
  fill(THEME_FOREGROUND_COL);
  strokeWeight(0);
      
  textSize(40);
  textAlign(CENTER, TOP);
  text(localisation.getString("UI_SCENE_INTRO"), width/2, 10);
  
  textSize(25);
  text(localisation.getString("UI_SCENE_INTRO_SUB1"), width/2, 120);
  text(localisation.getString("UI_SCENE_INTRO_SUB2"), width/2, 150);
  
  textSize(20);
  fill(THEME_HIGHLIGHT_COL);
  text(sketchPath(coreConfig.getString("mainLogFilePathAppend")), width/2, 185);  
 
  fill(THEME_FOREGROUND_COL);
  textAlign(CENTER, BOTTOM);
  text(localisation.getString("UI_SCENE_INTRO_SUB3"), width/2, height - 40);
  text(localisation.getString("UI_SCENE_INTRO_SUB4"), width/2, height - 10);
  
}

void safeExit(){
  
  saveDataToSave();
  super.exit();
  
}

void factoryReset(){
 
  JSONObject temp = new JSONObject();
  
  temp.setInt("theme", 0);
  temp.setInt("language", 0);
  temp.setBoolean("showTutorial", true);
  
  saveJSONObject(temp, coreConfig.getString("saveFileFilePath"));
  
  super.exit();
  
}
