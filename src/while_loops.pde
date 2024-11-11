int problem = 5;

/*

An introduction to while loops: where's the popcorn?

    \_\
   (_**)
  __) #_
 ( )...()
 || | |I|  |_|
 || | |()__/
 /\(___)
_-"""""""-_""-_
-,,,,,,,,- ,,-

Check out the worksheet for more detailed instructions.

*/

Robot robot;
Popcorn popcorn;

// P1: you've got to move your robot to the right until it is touching the popcorn.

void problem1() {
  // here's where your code goes for problem 1!
}

// P2: and now the popcorn by either to the left or right of you.

void problem2() {
  // here's where your code goes for problem 2!
}

// P3: and now the map is 2D!

void problem3() {
  // here's where your code goes for problem 3!
}


// P4: this problem is the same as problem 3 but now to win you have to "consume" the popcorn.
void problem4() {
  // here's where your code goes for problem 4!
}


// P5: now, you've got to find & consume them all! 


// count contains the amount of popcorn on the map.
int count;

// the scanner is your best friend for this problem. 
// scanner.nearestPopcorn() returns the popcorn that is closest to you.
Scanner scanner = new Scanner(); 

void problem5() {
  // here's where your code goes for problem 5!
}




































/*

         __
 _(\    |@@|
(__/\__ \--/ __
   \___|----|  |   __
       \ }{ /\ )_ / _\
       /\__/\ \__O (__
      (--/\--)    \__/
      _)(  )(_
     `---''---`

BELOW ARE THE INNER WORKINGS OF THE WORKSHEET :)

*/

void setup() {
  size(450, 30);
  switch(problem) {
    case 1:
      setupProblemOne();
      break;
    case 2:
      setupProblemTwoThreeFour();
      thread("problem2");
      break;
    case 3:
      windowResize(450, 450);
      setupProblemTwoThreeFour();
      thread("problem3");
      break;
    case 4:
      windowResize(450, 450);
      setupProblemTwoThreeFour();
      thread("problem4");
      break;
    default:
      windowResize(450, 450);
      setupProblemFive();
  }
}

import java.util.Map;
HashMap<int[],Integer> locations = new HashMap<int[],Integer>();

void setupProblemOne() {
  robot = new Robot();

  popcorn = new Popcorn();
  popcorn.randomiseLocation();
  
  thread("problem1");
}

void setupProblemTwoThreeFour() {
  robot = new Robot();

  popcorn = new Popcorn();
  popcorn.randomiseLocation();
  
  robot.randomiseLocation();
}

ArrayList<Popcorn> popcorns = new ArrayList();

void setupProblemFive() {
  robot = new Robot();
  robot.randomiseLocation();
  count = 3 + int(random(5));
  for(int i = 0; i < count; i++) {
    Popcorn popcornToAdd = new Popcorn();
    popcornToAdd.randomiseLocation();
    popcorns.add(popcornToAdd);
  }
  thread("problem5");
}

void draw() {
  background(255);
  textSize(28);
  fill(255);
  textAlign(CENTER, CENTER);
  for(float x = 30; x < 450; x += 30){
    line(x, 0, x, 450);
  }
  for(float y = 30; y < 450; y += 30){
    line(0, y, 450, y);
  }
  robot.draw();
  if(popcorn != null && problem != 5) {
    popcorn.draw();
  } else {
    boolean flag = true;
    for (int i = 0; i < popcorns.size(); i++) {
      if(!popcorns.get(i).hasBeenConsumed()) {
        flag = false;
        popcorns.get(i).draw();
      }
    }
    if(flag) {
      background(51, 214, 166);
      text("all the popcorn consumed!", width / 2, height / 2); 
    }
  }
  
  if(problem < 4 || problem == 4 && popcorn.hasBeenConsumed()){
    if(robot.isTouching(popcorn)) {
      background(51, 214, 166);
      if(!popcorn.hasBeenConsumed()) {
        text("popcorn acquired!", width / 2, height / 2); 
      } else {
        text("popcorn consumed!", width / 2, height / 2); 
      }
    }
  }
}

public class Character {
  PImage img;
  private int x = 0;
  private int y = 0;
  public void draw(){
    image(img, x, y, 30, 30);
  }
  public void randomiseLocation() {
    this.x = int(random(width / 30)) * 30;
    this.y = int(random(height / 30)) * 30;
    int[] location = {this.x, this.y};
    if(locations.containsKey(location)) {
      randomiseLocation();
    } else {
      locations.put(location, 1);
    }
  }
  
  public void move(int x, int y) {
    this.x += x;
    this.y += y;
    delay(500);
  }
  
  public boolean canMoveLeft() {
    return x > 0;
  }

  public void moveLeft() {
    if(canMoveLeft()){
      move(-30, 0);
    }
  }
  
  public boolean canMoveRight() {
    return x < 400;
  }

  public void moveRight() {
    if(canMoveRight()){
      move(30, 0);
    }
  }
  
  public boolean canMoveUp() {
    return y > 0;
  }
  
  public void moveUp() {
    if(canMoveUp()){
      move(0, -30);
    }
  }
  
  public boolean canMoveDown() {
    return y < 400;
  }

  public void moveDown() {
    if(canMoveDown()){
      move(0, 30);
    }
  }
  
  public boolean isTouching(Character c) {
    return c.x == this.x && c.y == this.y;
  }
  
  public boolean isOnTheSameXAxisAs(Character c) {
    return c.x == this.x;
  }
  
  public boolean isOnTheSameYAxisAs(Character c) {
    return c.y == this.y;
  }
  
  public int distanceFrom(Character c) {
    return Math.abs(c.x - this.x) + Math.abs(c.y - this.y);
  }
  
  public void eat(Popcorn p) {
    if(this.isTouching(p)){
      p.consumed = true;
    } else {
      print("You can't consume this! You need to be 'touching' popcorn to eat it.");
    }
  }
}

public class Robot extends Character {
  public Robot() {
    this.img = loadImage("robot.png");
  }
}

public class Popcorn extends Character {
  private boolean consumed = false;
  
  public Popcorn() {
    this.img = loadImage("popcorn.png");
  }
  
  public void eat(Character c) {
    if(this.isTouching(c)){
      this.consumed = true;
    }
  }
  
  public boolean hasBeenConsumed(){
    return consumed;
  }
  
}

public class Scanner {
  public Popcorn nearestPopcorn() {
    Popcorn closest = null;
    for (int i = 0; i < popcorns.size(); i++) {
      if(!popcorns.get(i).hasBeenConsumed() && (closest == null || robot.distanceFrom(popcorns.get(i)) < robot.distanceFrom(closest))) {
        closest = popcorns.get(i);
      }
    }
    return closest;
  }
}
