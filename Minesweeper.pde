

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs =  new ArrayList <MSButton>();
int NUM_ROWS=20;
int NUM_COLS=20;
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to declare and initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int y = 0; y<NUM_ROWS; y++) {
    for (int x = 0; x<NUM_COLS; x++) {
      buttons[y][x] = new MSButton(y, x);
    }
  }    
  for (int i =0; i<30; i++) {
    setBombs();
  }
}
public void setBombs()
{
  //your code
  int rcol = (int)(Math.random()*20);
  int rrow = (int)(Math.random()*20);

  if (!bombs.contains(buttons[rrow][rcol])) {
    bombs.add(buttons[rrow][rcol]);
  }
}

public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  return false;
}
public void displayLosingMessage()
{
  //your code here
}
public void displayWinningMessage()
{
  //your code here
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;
  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    if (keyPressed) {
      marked = true;
    } else if (bombs.contains(buttons[r][c])) {
      System.out.println("you lose");
      displayLosingMessage();
    } else if (countBombs(r, c)>0) {
      System.out.println("yes");
      setLabel( " "+countBombs(r, c));
    } 
    if (marked == true)
    {
      marked = false;
      if (isValid(r, c+1) && !bombs.contains(buttons[r][c+1])) {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r, c-1) && !bombs.contains(buttons[r][c-1])) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r+1, c) && !bombs.contains(buttons[r+1][c])) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r-1, c) && !bombs.contains(buttons[r-1][c])) {
        buttons[r-1][c].mousePressed();
      }
      
        if (isValid(r+1, c+1) && !bombs.contains(buttons[r+1][c+1])) {
        buttons[r+1][c+1].mousePressed();
      }
      if (isValid(r-1, c-1) && !bombs.contains(buttons[r-1][c-1])) {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r+1, c-1) && !bombs.contains(buttons[r+1][c-1])) {
        buttons[r+1][c-1].mousePressed();
      }
      if (isValid(r-1, c+1) && !bombs.contains(buttons[r-1][c+1])) {
        buttons[r-1][c+1].mousePressed();
      }



      //3 more recursive calls
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
      fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if (r<0 || r>19 || c<0 || c>19  ) {
      return false;
    } else {
      return true;
    }
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if (isValid(row-1, col) && bombs.contains(buttons[row-1][col])) {
      numBombs++;
    }
    if (isValid(row+1, col) && bombs.contains(buttons[row+1][col])) {
      numBombs++;
    }
    if (isValid(row, col-1) && bombs.contains(buttons[row][col-1])) {
      numBombs++;
    }
    if (isValid(row, col+1) && bombs.contains(buttons[row][col+1])) {
      numBombs++;
    }
    if (isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1])) {
      numBombs++;
    }
    if (isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1])) {
      numBombs++;
    }
    if (isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1])) {
      numBombs++;
    }
    if (isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1])) {
      numBombs++;
    }
    return numBombs;
  }
}
