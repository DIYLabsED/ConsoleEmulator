final String PROJECT_LIST_FILE_FILEPATH = "projects/list.json";


void projectSelector(){
  
  if(projectMenuBack.handle()){
    scene = SCENE_HOME; 
  }
  
  fill(THEME_FOREGROUND_COL);
  strokeWeight(0);
      
  textSize(40);
  textAlign(CENTER, TOP);
  text(localisation.getString("UI_SCENE_PROJECT_SELECT"), width/2, 10);

  textSize(18);
  text(localisation.getString("UI_SCENE_PROJECT_SELECT_SUB1"), width/2, 60);
  



}
