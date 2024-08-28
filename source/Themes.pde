String THEME_FILE_FILEPATH;
final int LATEST_THEME_FILE_VERSION = 0;

JSONArray themes;

color THEME_BACKGROUND_COL, THEME_FOREGROUND_COL, THEME_HIGHLIGHT_COL, THEME_ERROR_MAJOR_COL, THEME_UNAVAILABLE_COL;
PFont THEME_FONT;
int textMatrixAlpha;

int selectedTheme = 0;

boolean themeInit(){
 
  themes = loadJSONArray(THEME_FILE_FILEPATH);
  
  if(themes == null){
    
    println("Unable to load theme file");
    return false;
    
  }
  
  loadTheme(selectedTheme);
  
  return true;
  
}

void themeSelector(){
  
  if(themeMenuBack.handle()){
   
    scene = SCENE_SETTINGS;
    
  }
  
  fill(THEME_FOREGROUND_COL);
  strokeWeight(0);
      
  textSize(40);
  textAlign(CENTER, TOP);
  text(localisation.getString("UI_SCENE_THEMES"), width/2, 10);

  textSize(18);
  text(localisation.getString("UI_SCENE_THEMES_SUB1"), width/2, 60);
  
  fill(THEME_ERROR_MAJOR_COL);
  textSize(18);
  text(localisation.getString("UI_SCENE_THEMES_SUB2"), width/2, 80);
  
  for(int i = 0; i < themes.size(); i++){

    fill(THEME_FOREGROUND_COL);
    strokeWeight(0);
    
    JSONObject t = themes.getJSONObject(i);
  
    // [id] name    creator
    int textSize = 30;
    int marginX = 20;
    int marginY = 5;
    int initialX = marginX; // topleft
    int initialY = 120;
    int nameX;
    int creatorX = width - marginX; // topright!
    
    float yOffset = initialY + (i * textSize);
    float selectionYOffset = initialY + (selectedTheme * textSize) - 2;
    
    float selectionYMargin = textDescent() / 3;
    
    textSize(textSize - (textSize  / 5));
    textAlign(LEFT, TOP);
    
    String id = "[" + str(i) + "]";
    int maxIDWidth = int(textWidth("[99]"));
    nameX = initialX + maxIDWidth + marginX;
    
    text(id, initialX, yOffset);
    
    if(t.getInt("version") < LATEST_THEME_FILE_VERSION){
      
      fill(THEME_ERROR_MAJOR_COL);
      
    }
    text(t.getString("themeName"), nameX, yOffset);
    
    fill(THEME_FOREGROUND_COL);
    textAlign(RIGHT, TOP);
    text(localisation.getString("UI_SCENE_THEMES_CREATOR_PRETEXT") + t.getString("creator"), creatorX, yOffset);
    
    fill(0, 0, 0, 0);
    stroke(THEME_HIGHLIGHT_COL);
    strokeWeight(1.5);
    rect(initialX - (marginX/2), selectionYOffset - selectionYMargin, creatorX , textSize - selectionYMargin);
    
  } 
    
}


void loadTheme(int selection){
 
  JSONObject theme = themes.getJSONObject(selection);
  
  if(theme.getInt("version") < LATEST_THEME_FILE_VERSION){
    
    return;
    
  }
  
  THEME_BACKGROUND_COL  = color(theme.getInt("backgroundColorR"), theme.getInt("backgroundColorG"), theme.getInt("backgroundColorB"));
  THEME_FOREGROUND_COL  = color(theme.getInt("foregroundColorR"), theme.getInt("foregroundColorG"), theme.getInt("foregroundColorB"));
  THEME_HIGHLIGHT_COL   = color(theme.getInt("highlightColorR"), theme.getInt("highlightColorG"), theme.getInt("highlightColorB"));
  THEME_ERROR_MAJOR_COL = color(theme.getInt("majorErrorColorR"), theme.getInt("majorErrorColorG"), theme.getInt("majorErrorColorB"));
  THEME_UNAVAILABLE_COL = color(theme.getInt("unavailableColorR"), theme.getInt("unavailableColorG"), theme.getInt("unavailableColorB"));
  THEME_FONT = createFont(theme.getString("fontFile"), 100);
  textFont(THEME_FONT);
  
  textMatrixAlpha = theme.getInt("textMatrixAlpha");

  loadUIElements(); // Reload UI elements to apply new colors
    
  saveDataToSave();
    
}

void handleThemeIncrement(){
  
  selectedTheme = (selectedTheme + themes.size() + 1) % themes.size();
  loadTheme(selectedTheme);
  
}
void handleThemeDecrement(){

  selectedTheme = (selectedTheme + themes.size() - 1) % themes.size();
  loadTheme(selectedTheme);
  
}
