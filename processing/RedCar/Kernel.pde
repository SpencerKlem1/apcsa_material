 public class Kernel {
  float[][]kernel;// = new float[3][3];

  /**Constructor takes the kernel that will be applied to the image
  *This implementation only allows 3x3 kernels
  */
  public Kernel(float[][]init) {
    kernel = new float[3][3];
    for (int i = 0; i < init.length; i++) {
     for (int j = 0; j < init[i].length; j++) {
      kernel[i][j] = init[i][j];
     }
    }
  }

  /**If part of the kernel is off of the image, return black, Otherwise
  *Calculate the convolution of r/g/b separately, and return that color\
  *if the calculation for any of the r,g,b values is outside the range
  *     0-255, then clamp it to that range (< 0 becomes 0, >255 becomes 255)
  */
 color calcNewColor(PImage img, int x, int y) {
   float re;
   float gr;
   float bl;
   float sum1 = 0;
   int curX;
   int curY;
   for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
     curX = x + 1 - row;
     curY = y + 1 - col;
     if (curX < 0 || curX > width || curY < 0 || curY > width) {
       sum1 += 0;
      } else {
       sum1 += kernel[row][col] * red(img.get(curX, curY));
      }
   }
  }
  re = sum1;
  sum1 = 0;
   for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
     curX = x + 1 - row;
     curY = y + 1 - col;
     if (curX < 0 || curX > width || curY < 0 || curY > width) {
       sum1 += 0;
      } else {
       sum1 += kernel[row][col] * green(img.get(curX, curY));
      }
   }
  }
  gr = sum1;
  sum1 = 0;
   for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
     curX = x + 1 - row;
     curY = y + 1 - col;
     if (curX < 0 || curX > width || curY < 0 || curY > width) {
       sum1 += 0;
      } else {
       sum1 += kernel[row][col] * blue(img.get(curX, curY));
      }
   }
  }
  bl = sum1;
 
  return color(re, gr, bl);
 }
  

  /**Apply the kernel to the source,
  *and saves the data to the destination.*/
  void apply(PImage source, PImage destination) {
   for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
     destination.set(x, y, calcNewColor(source, x, y));
     }
    }
  }

}
