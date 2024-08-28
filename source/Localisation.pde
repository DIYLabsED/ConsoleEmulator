String LOCALISATION_FILE_FILEPATH;
JSONObject localisation;
JSONArray languages;

int selectedLanguage = 0;

boolean localisationInit(){
 
  languages = loadJSONArray(LOCALISATION_FILE_FILEPATH);
  
  if(languages == null){
    
    println("Unable to load loc file");
    return false;
    
  }
  
  loadLanguage(selectedLanguage);
  
  return true;
  
}

void loadLanguage(int index){
 
  localisation = languages.getJSONObject(index);
  loadUIElements();
  saveDataToSave();
  
}

void languageSelector(){
  
  if(languageMenuBack.handle()){
   
    scene = SCENE_SETTINGS;
    
  }
  
  fill(THEME_FOREGROUND_COL);
  strokeWeight(0);
      
  textSize(40);
  textAlign(CENTER, TOP);
  text(localisation.getString("UI_SCENE_LANGUAGES"), width/2, 10);

  textSize(18);
  text(localisation.getString("UI_SCENE_LANGUAGES_SUB1"), width/2, 60);
  text(localisation.getString("UI_SCENE_LANGUAGES_SUB2"), width/2, 80);

  
  for(int i = 0; i < languages.size(); i++){

    fill(THEME_FOREGROUND_COL);
    strokeWeight(0);
    
    JSONObject l = languages.getJSONObject(i);
  
    // [id] name    creator
    int textSize = 30;
    int marginX = 20;
    int marginY = 5;
    int initialX = marginX; // topleft
    int initialY = 120;
    int nameX;
    int creatorX = width - marginX; // topright!
    
    float yOffset = initialY + (i * textSize);
    float selectionYOffset = initialY + (selectedLanguage * textSize) - 2;
    
    float selectionYMargin = textDescent() / 3;
    
    textSize(textSize - (textSize  / 5));
    textAlign(LEFT, TOP);
    
    String id = "[" + str(i) + "]";
    int maxIDWidth = int(textWidth("[99]"));
    nameX = initialX + maxIDWidth + marginX;
    
    text(id, initialX, yOffset);
    
    text(l.getString("language"), nameX, yOffset);
    
    fill(THEME_FOREGROUND_COL);
    textAlign(RIGHT, TOP);
    text(localisation.getString("UI_SCENE_LANGUAGES_CREATOR_PRETEXT") + l.getString("creator"), creatorX, yOffset);
    
    fill(0, 0, 0, 0);
    stroke(THEME_HIGHLIGHT_COL);
    strokeWeight(1.5);
    rect(initialX - (marginX/2), selectionYOffset - selectionYMargin, creatorX , textSize - selectionYMargin);
        
  } 

    
}

void handleLanguageIncrement(){
  
  selectedLanguage = (selectedLanguage + languages.size() + 1) % languages.size();
  loadLanguage(selectedLanguage);
  
}
void handleLanguageDecrement(){

  selectedLanguage = (selectedLanguage + languages.size() - 1) % languages.size();
  loadLanguage(selectedLanguage);
  
}

void introPrequel(){
  
  fill(THEME_FOREGROUND_COL);
  strokeWeight(0);
      
  textSize(40);
  textAlign(CENTER, TOP);
  text(localisation.getString("UI_SCENE_LANGUAGES"), width/2, 10);

  textSize(18);
  text(localisation.getString("UI_SCENE_LANGUAGES_SUB1"), width/2, 60);
  text(localisation.getString("UI_SCENE_LANGUAGES_SUB2"), width/2, 80);  
  
  for(int i = 0; i < languages.size(); i++){

    fill(THEME_FOREGROUND_COL);
    strokeWeight(0);
    
    JSONObject l = languages.getJSONObject(i);
  
    // [id] name    creator
    int textSize = 30;
    int marginX = 20;
    int marginY = 5;
    int initialX = marginX; // topleft
    int initialY = 120;
    int nameX;
    int creatorX = width - marginX; // topright!
    
    float yOffset = initialY + (i * textSize);
    float selectionYOffset = initialY + (selectedLanguage * textSize) - 2;
    
    float selectionYMargin = textDescent() / 3;
    
    textSize(textSize - (textSize  / 5));
    textAlign(LEFT, TOP);
    
    String id = "[" + str(i) + "]";
    int maxIDWidth = int(textWidth("[99]"));
    nameX = initialX + maxIDWidth + marginX;
    
    text(id, initialX, yOffset);
    
    text(l.getString("language"), nameX, yOffset);
    
    fill(THEME_FOREGROUND_COL);
    textAlign(RIGHT, TOP);
    text(localisation.getString("UI_SCENE_LANGUAGES_CREATOR_PRETEXT") + l.getString("creator"), creatorX, yOffset);
    
    fill(0, 0, 0, 0);
    stroke(THEME_HIGHLIGHT_COL);
    strokeWeight(1.5);
    rect(initialX - (marginX/2), selectionYOffset - selectionYMargin, creatorX , textSize - selectionYMargin);
        
  }   

  if(introMenuNext.handle()){
    scene = SCENE_INTRO_TUTORIAL; 
  }
  
}
