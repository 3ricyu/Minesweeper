
import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 40;
public boolean gameOver = false;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  background(0);
  size(400, 500);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLS; c++)
      buttons[r][c] = new MSButton(r, c);

  setBombs();
}
public void setBombs()
{
  while (bombs.size() < NUM_BOMBS)
  {
    int r = (int)(Math.random()* NUM_ROWS);
    int c = (int)(Math.random()* NUM_COLS);
    if (!bombs.contains(buttons[r][c]))
      bombs.add(buttons[r][c]);
  }
  //your code
}

public void draw ()
{
  if (isWon())
  {
    gameOver = true;
    displayWinningMessage();
  }
}
public boolean isWon()
{
  for ( int r = 0; r < NUM_ROWS; r++) {
    for ( int c = 0; c < NUM_COLS; c++) {
      if (bombs.contains(buttons[r][c]) && buttons[r][c].marked == false)
       {
         return false;
       }
    }
  }
     return true;

}
public void displayLosingMessage()
{
  for ( int r = 0; r < NUM_ROWS; r++) {
    for ( int c = 0; c < NUM_COLS; c++) {
      if (bombs.contains(buttons[r][c])) {
        buttons[r][c].clicked = true;
        buttons[r][c].setLabel("!");
      }
      //your code here
    }
  }
   fill(255);
   text("YOU LOSE", 200, 450);
}
    public void displayWinningMessage()
    {
      fill(255);
      text("YOU WIN", 200, 450);
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
        if(gameOver == false){
          clicked = true;
          if (mouseButton == RIGHT) {
            marked = !marked;
            if (marked == false)
              clicked = false;
          } else if (bombs.contains(this))
          {
            gameOver = true;
            displayLosingMessage();
          }
          else if (countBombs(r, c) > 0)
            setLabel(""+countBombs(r, c));
          else
          {
            if (isValid(r, c-1) && buttons[r][c-1].isClicked()== false) {
              buttons[r][c-1].mousePressed();
            }
            if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked()== false) {
              buttons[r-1][c-1].mousePressed();
            }
            if (isValid(r-1, c) && buttons[r-1][c].isClicked()== false) {
              buttons[r-1][c].mousePressed();
            }
            if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked()== false) {
              buttons[r-1][c+1].mousePressed();
            }
            if (isValid(r, c+1) && buttons[r][c+1].isClicked()== false) {
              buttons[r][c+1].mousePressed();
            }
            if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked()== false) {
              buttons[r+1][c+1].mousePressed();
            }
            if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false) {
              buttons[r+1][c].mousePressed();
            }
            if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false) {
              buttons[r+1][c-1].mousePressed();
            }
          }
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
        if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
          return true;
        //your code here
        return false;
      }
      public int countBombs(int row, int col)
      {
        int numBombs = 0;
        for (int r = row-1; r<=row+1; r++)
          for (int c = col-1; c<=col+1; c++)
            if (isValid(r, c) && bombs.contains(buttons[r][c]))
              numBombs++;
        if (bombs.contains(buttons[row][col]))
          numBombs--;
        //your code here
        return numBombs;
      }
    }
