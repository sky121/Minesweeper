

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs =  new ArrayList <MSButton>();
int NUM_ROWS=20;
int NUM_COLS=20;
public boolean wine;
public boolean l;
int winM;
int rcol;
int rrow;
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);
  l = false;
  // make the manager
  Interactive.make( this );

  //your code to declare and initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int y = 0; y<NUM_ROWS; y++) {
    for (int x = 0; x<NUM_COLS; x++) {
      buttons[y][x] = new MSButton(y, x);
    }
  }    
  for (int i =0; i<5; i++) {
    setBombs();
    winM++;
  }
}
public void setBombs()
{
  //your code
  rcol = (int)(Math.random()*20);
  rrow = (int)(Math.random()*20);

  if (!bombs.contains(buttons[rrow][rcol])) {
    bombs.add(buttons[rrow][rcol]);
  }
}

public void draw ()
{
  background(0);
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  if (winM==0) {
    return true;
  }
  return false;
}
public void displayLosingMessage()
{
  String ltext = "YOU LOSEr";
      for (int i = 0; i<8; i++) {
        buttons[10][i+4].setLabel(ltext.substring(i, i+1));
      }
      noLoop();
}
public void displayWinningMessage()
{
  //your code here
  String ltext = "YOU WINNN";
  for (int i = 0; i<8; i++) {
    buttons[10][i+4].setLabel(ltext.substring(i, i+1));
  }
  noLoop();
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

   
      
  
     clicked=true;
   if (mouseButton==RIGHT&&marked==false) {
      marked = true;
    
      if (bombs.contains(this)) {
        winM--;
      }
    } else if (mouseButton==LEFT && bombs.contains(this)&&marked==false) {
      
      for (int i = 0; i<20; i++) {
        for (int a = 0; a<20; a++) {
          buttons[i][a].clicked=true;
        }
      }
      displayLosingMessage();
    } else if (mouseButton==RIGHT&&marked==true) {
      marked=false;
      clicked=false;
      if (bombs.contains(this)) {
        winM++;
      }
    } else if (countBombs(r, c)>0&&marked==false) {
      setLabel( " "+countBombs(r, c));
    } else { 


      if (isValid(r, c+1) &&buttons[r][c+1].isClicked()==false) {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r, c-1) &&buttons[r][c-1].isClicked()==false) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r+1, c) &&buttons[r+1][c].isClicked()==false) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r-1, c) &&buttons[r-1][c].isClicked()==false) {
        buttons[r-1][c].mousePressed();
      }

      if (isValid(r+1, c+1) &&buttons[r+1][c+1].isClicked()==false) {
        buttons[r+1][c+1].mousePressed();
      }
      if (isValid(r-1, c-1) &&buttons[r-1][c-1].isClicked()==false) {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r+1, c-1) &&buttons[r+1][c-1].isClicked()==false) {
        buttons[r+1][c-1].mousePressed();
      }
      if (isValid(r-1, c+1) &&buttons[r-1][c+1].isClicked()==false) {
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
