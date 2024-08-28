final String PROJECT_LIST_FILE_FILEPATH = "projects/list.json";

JSONArray projectList;
JSONObject projectListSelected;

int selectedProject = 0;

final String[] renderers = {"r1", "renderer1"};

boolean projectInit(){
  
  projectList = loadJSONArray(PROJECT_LIST_FILE_FILEPATH);
  
  if(projectList == null){
    
    println("Unable to load project list file");
    return false;
    
  }
  
  loadProjectFromList();
  
  return true;
  
}

void projectSelector(){
  
  if(projectMenuBack.handle()){
    scene = SCENE_HOME; 
  }
  
  if(projectMenuLoad.handle()){
    
  }
  
  fill(THEME_FOREGROUND_COL);
  strokeWeight(0);
      
  textSize(40);
  textAlign(CENTER, TOP);
  text(localisation.getString("UI_SCENE_PROJECT_SELECT"), width/2, 10);

  textSize(18);
  text(localisation.getString("UI_SCENE_PROJECT_SELECT_SUB1"), width/2, 60);
  

  for(int i = 0; i < projectList.size(); i++){

    fill(THEME_FOREGROUND_COL);
    strokeWeight(0);
    
    JSONObject p = projectList.getJSONObject(i);
  
    // [id] name    creator
    int textSize = 30;
    int marginX = 20;
    int marginY = 5;
    int initialX = marginX; // topleft
    int initialY = 120;
    int nameX;
    int creatorX = width - marginX; // topright!
    
    float yOffset = initialY + (i * textSize);
    float selectionYOffset = initialY + (selectedProject * textSize) - 2;
    
    float selectionYMargin = textDescent() / 3;
    
    textSize(textSize - (textSize  / 5));
    textAlign(LEFT, TOP);
    
    String id = "[" + str(i) + "]";
    int maxIDWidth = int(textWidth("[99]"));
    nameX = initialX + maxIDWidth + marginX;
    
    text(id, initialX, yOffset);

    text(p.getString("name"), nameX, yOffset);
        
    fill(0, 0, 0, 0);
    stroke(THEME_HIGHLIGHT_COL);
    strokeWeight(1.5);
    rect(initialX - (marginX/2), selectionYOffset - selectionYMargin, (width/2) - (marginX * 2) , textSize - selectionYMargin);
        
    strokeWeight(2);
    line(width/2, 100, width/2, height - 10);
    
    line((width/2) + 10, 100, width - 10, 100); 
    
    textSize(40);
    strokeWeight(0);
    fill(THEME_FOREGROUND_COL);
    textAlign(CENTER, TOP);
    text(localisation.getString("UI_SCENE_PROJECT_SELECT_INFO"), (width/4) * 3, 110);

    textSize(textSize);    
    text(localisation.getString("UI_SCENE_PROJECT_SELECT_RENDERER"), (width/4) * 3, initialY + (textSize*1.5));
    text(localisation.getString("UI_SCENE_PROJECT_SELECT_FILEPATH"), (width/4) * 3, initialY + (textSize*4));
    text(localisation.getString("UI_SCENE_PROJECT_SELECT_CREATOR"), (width/4) * 3, initialY + (textSize*6.5));
    
    fill(THEME_HIGHLIGHT_COL);    
    text(projectListSelected.getString("renderer"), (width/4) * 3, initialY + (textSize * 2.5));
    text(projectListSelected.getString("projectFile"), (width/4) * 3, initialY + (textSize * 5));
    text(projectListSelected.getString("creator"), (width/4) * 3, initialY + (textSize * 7.5));
    
        
  } 
  
}

void handleProjectIncrement(){

  selectedProject = (selectedProject + projectList.size() + 1) % projectList.size();
  loadProjectFromList();

}

void handleProjectDecrement(){

  selectedProject = (selectedProject + projectList.size() - 1) % projectList.size();
  loadProjectFromList();
  
}

void loadProjectFromList(){
  
  projectListSelected = projectList.getJSONObject(selectedProject);
    
}
