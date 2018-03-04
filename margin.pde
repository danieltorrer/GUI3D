int controlOffset = 300;
  
class Toolbar {
  int barWidth;
  int GAP;           // pixel distance from edge of screen
  int u_width;       // pixel width of margin content
  int V_OFFSET = 35; // standard vertical pixel distance between control elements
  int U_OFFSET = 25; // standard horizontal pixel distance from edge of canvas
  
  String title, credit, explanation;
  
  ControlSlider s1;
  ControlSlider s2;
  ControlSlider s3;
  ControlSlider s4;
  
  RadioButton b1;
  RadioButton b2;
  RadioButton b3;
  
  Toolbar(int w, int g) {
    barWidth = w;
    GAP = g;
    u_width = barWidth - 3*U_OFFSET;
    initControls();
  }
  
  void initControls() {
    int num = 0;
    
    s1 = new ControlSlider();
    s1.name = "Slider 1";
    s1.unit = "%";
    s1.keyPlus = 'w';
    s1.keyMinus = 'q';
    s1.xpos = GAP + U_OFFSET;
    s1.ypos = controlOffset + num*V_OFFSET;
    s1.len = u_width;
    s1.valMin = 0;
    s1.valMax = 100;
    s1.value = 50;
    
    num++;
    
    s2 = new ControlSlider();
    s2.name = "Slider 2";
    s2.unit = "%";
    s2.keyPlus = 's';
    s2.keyMinus = 'a';
    s2.xpos = GAP + U_OFFSET;
    s2.ypos = controlOffset + num*V_OFFSET;
    s2.len = u_width;
    s2.valMin = 0;
    s2.valMax = 100;
    s2.value = 50;
    
    num++;
    
    s3 = new ControlSlider();
    s3.name = "Slider 3";
    s3.unit = "%";
    s3.keyPlus = 'x';
    s3.keyMinus = 'z';
    s3.xpos = GAP + U_OFFSET;
    s3.ypos = controlOffset + num*V_OFFSET;
    s3.len = u_width;
    s3.valMin = 0;
    s3.valMax = 100;
    s3.value = 50;
    
    num++;
    
    s4 = new ControlSlider();
    s4.name = "Slider 3";
    s4.unit = "%";
    s4.keyPlus = 'x';
    s4.keyMinus = 'z';
    s4.xpos = GAP + U_OFFSET;
    s4.ypos = controlOffset + num*V_OFFSET;
    s4.len = u_width;
    s4.valMin = 0;
    s4.valMax = 100;
    s4.value = 50;
    
    num+=2;
    
    b1 = new RadioButton();
    b1.name = "Button 1";
    b1.keyToggle = '1';
    b1.xpos = GAP + U_OFFSET;
    b1.ypos = controlOffset + num*V_OFFSET;
    b1.value = false;
    
    num++;
    
    b2 = new RadioButton();
    b2.name = "Button 2";
    b2.keyToggle = '2';
    b2.xpos = GAP + U_OFFSET;
    b2.ypos = controlOffset + num*V_OFFSET;
    b2.value = false;
    
    num++;
    
    b3 = new RadioButton();
    b3.name = "Button 3";
    b3.keyToggle = '3';
    b3.xpos = GAP + U_OFFSET;
    b3.ypos = controlOffset + num*V_OFFSET;
    b3.value = false;
  }
  
  void pressed() {
    s1.listen();
    s2.listen();
    s3.listen(); 
    s4.listen(); 
    
    b1.listen(); 
    b2.listen(); 
    b3.listen(); 
  }
  
  void released() {
    s1.isDragged = false;
    s2.isDragged = false;
    s3.isDragged = false;
    s4.isDragged = false;
  }
  
  void restoreDefault() {
    s1.value = 50;
    s2.value = 50;
    s3.value = 50;
    s4.value = 50;
    
    b1.value = false;
    b2.value = false;
    b3.value = false;
  }
  
  // Draw Margin Elements
  //
  void draw() {
    camera();
    noLights();
    perspective();
    hint(DISABLE_DEPTH_TEST);
    
    pushMatrix();
    translate(GAP, GAP);
    
    // Shadow
    pushMatrix();
    translate(3, 3);
    noStroke();
    fill(0, 100);
    rect(0, 0, barWidth, height - 2*GAP, GAP);
    popMatrix();
    
    // Canvas
    fill(255, 50);
    noStroke();
    rect(0, 0, barWidth, height - 2*GAP, GAP);
    translate(U_OFFSET, U_OFFSET);
    textAlign(LEFT, TOP);
    fill(255);
    text(title + "\n" + credit + "\n\n" + explanation, 0, 0, barWidth - 2*U_OFFSET, height - 2*GAP - 2*U_OFFSET);
    popMatrix();
    
    s1.update();
    s1.drawMe();
    
    s2.update();
    s2.drawMe();
    
    s3.update();
    s3.drawMe();
    
    s4.update();
    s4.drawMe();
    
    b1.drawMe();
    b2.drawMe();
    b3.drawMe();
    
    hint(ENABLE_DEPTH_TEST);
  }
  
  boolean hover() {
    if (mouseX > GAP && mouseX < GAP + barWidth && 
        mouseY > GAP && mouseY < height - GAP) {
      return true;
    } else {
      return false;
    }
  }
}

class ControlSlider {
  String name;
  String unit;
  int xpos;
  int ypos;
  int len;
  int diameter;
  char keyMinus;
  char keyPlus;
  boolean isDragged;
  int valMin;
  int valMax;
  float value;
  
  ControlSlider() {
    xpos = 0;
    ypos = 0;
    len = 200;
    diameter = 15;
    keyMinus = '-';
    keyPlus = '+';
    isDragged = false;
    valMin = 0;
    valMax = 0;
    value = 0;
  }
  
  void update() {
    //Keyboard Controls
    if ((keyPressed == true) && (key == keyMinus)) {value--;}
    if ((keyPressed == true) && (key == keyPlus))  {value++;}
    
    if (isDragged) {
      value = (mouseX-xpos)*(valMax-valMin)/len+valMin;
    }
  
    if(value < valMin) value = valMin;
    if(value > valMax) value = valMax;
  }
  
  void listen() {
    if((mouseY > (ypos-diameter/2)) && (mouseY < (ypos+diameter/2)) && (mouseX > (xpos-diameter/2)) && (mouseX < (xpos+len+diameter/2))) {
      isDragged = true;
    }
  }
  
  void drawMe() {

    // Slider Info
    strokeWeight(1);
    fill(255);
    textAlign(LEFT, BOTTOM);
    text(name,xpos,ypos-0.75*diameter);
    textAlign(LEFT, CENTER);
    text(int(value) + " " + unit,xpos+6+len,ypos-1);
    
    // Slider Bar
    fill(100);
    noStroke();
    rect(xpos,ypos-0.15*diameter,len,0.3*diameter,diameter);
    
    // Slider Circle
    noStroke();
    fill(200);
    ellipse(xpos+0.5*diameter+(len-1.0*diameter)*(value-valMin)/(valMax-valMin),ypos,diameter,diameter);
  }
}

class RadioButton {
  String name;
  int col;
  int xpos;
  int ypos;
  int diameter;
  char keyToggle;
  int valMin;
  int valMax;
  boolean value;
  
  RadioButton() {
    xpos = 0;
    ypos = 0;
    diameter = 20;
    keyToggle = ' ';
    value = false;
    col = #FFFFFF;
  }
  
  void listen() {
    
    // Mouse Controls
    if((mouseY > (ypos-diameter/2)) && (mouseY < (ypos+diameter/2)) && (mouseX > xpos) && (mouseX < xpos+diameter)) {
      value = !value;
    }
    
    // Keyboard Controls
    if ((keyPressed == true) && (key == keyToggle)) {value = !value;}
  }
  
  void drawMe() {
    
    // Button Info
    strokeWeight(1);
    fill(255);
    textAlign(LEFT, CENTER);
    text(name,xpos + 1.5*diameter,ypos);
    
    // Button Holder
    noFill();
    stroke(100);
    strokeWeight(3);
    ellipse(xpos+0.5*diameter,ypos,diameter,diameter);
    
    // Button Circle
    noStroke();
    if (value) { fill(col); } 
    else       { fill( 0 ); } 
    ellipse(xpos+0.5*diameter,ypos,0.7*diameter,0.7*diameter);
  }
}