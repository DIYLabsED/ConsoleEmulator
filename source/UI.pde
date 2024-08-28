final int UI_BUTTON_CENTER = -1;

class UIButton{
   
  int buttonWidth;
  int buttonHeight;
  int buttonX;
  int buttonY;
  float buttonRadius;
  int buttonStrokeWeight;
  color buttonFillCol;
  color buttonFillHighlightCol;
  color buttonStrokeCol;
  color buttonStrokeHighlightCol;
  String buttonText;
  int buttonTextSize;
  color buttonTextCol;
  color buttonTextHighlightCol;
  
  UIButton(int w, int h, int x, int y, int weight, color f, color fh, color s, color sh, color c, color ch, String t){
   
    buttonWidth = w;
    buttonHeight = h;
    
    if(x == UI_BUTTON_CENTER){
     
      buttonX = (width/2) - (buttonWidth/2);
      
    }
    else{
      
      buttonX = x;
    
    }
    
    if(y == UI_BUTTON_CENTER){
     
      buttonY = (height/2) - (buttonHeight/2);
      
    }
    else{
      
      buttonY = y;
    
    }
    
    buttonRadius = buttonHeight - (buttonHeight/1.3);
    buttonStrokeWeight = weight;
    buttonFillCol = f;
    buttonFillHighlightCol = fh;
    buttonStrokeCol = s;
    buttonStrokeHighlightCol = sh;
    buttonTextCol = c;
    buttonTextHighlightCol = ch;
    buttonText = t;    
    buttonTextSize = buttonHeight - 10;
    
  }
  
  boolean handle(){
    
    if(isMouseReleased){
           
      if(isMouseOver(buttonX, buttonY, buttonX + buttonWidth, buttonY + buttonHeight) && isXYOver(buttonX, buttonY, buttonX + buttonWidth, buttonY + buttonHeight, mouseReleasedX, mouseReleasedY)){
       
        if(transparentButtons){
          fill(0, 0, 0, 0); 
        }
        else{
          fill(buttonFillCol);
        }
        stroke(buttonStrokeHighlightCol);
        strokeWeight(buttonStrokeWeight);
        rect(buttonX, buttonY, buttonWidth, buttonHeight, buttonRadius);
        textAlign(CENTER, CENTER);
        textSize(buttonTextSize);
        fill(buttonTextHighlightCol);
        text(buttonText, buttonX + (buttonWidth/2), buttonY + (buttonHeight/2));
        isMouseReleased = false;
        return true;
   
      }
      
    }
    
    if(transparentButtons){
      fill(0, 0, 0, 0); 
    }
    else{
      fill(buttonFillCol);
    }
    stroke(buttonStrokeCol);
    strokeWeight(buttonStrokeWeight);
    rect(buttonX, buttonY, buttonWidth, buttonHeight, buttonRadius);
    textAlign(CENTER, CENTER);
    textSize(buttonTextSize);
    fill(buttonTextCol);
    text(buttonText, buttonX + (buttonWidth/2), buttonY + (buttonHeight/2));
 
    return false;     
    
    
  }
  
  boolean isMouseOver(int x1, int y1, int x2, int y2){
    
    return (mouseX > x1) && (mouseX < x2) && (mouseY > y1) && (mouseY < y2);
  
  }
  
  boolean isXYOver(int x1, int y1, int x2, int y2, int pX, int pY){
    
    return (pX > x1) && (pX < x2) && (pY > y1) && (pY < y2);
  
  }
  
}
