#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define BITSPERBYTE 8
#define HEADERBYTES 2

#define NUMFRAMES 256

void drawbin(const uint8_t *data)
{
  uint8_t mask=0x80;

  while (mask>0)
  {
    printf("%c", (((*data)&mask)>0)?'#':' ');
    printf("%c", (((*data)&mask)>0)?'#':' ');

    mask>>=1;
  }
}

void drawbin_width(const uint8_t *data, const uint8_t width)
{
  uint8_t done=0;

  printf("|");
  
  while ((done*8)<width)
  {
    drawbin(&data[done]);

    done++;
  }
  
  printf("|\n");
}

int main()
{
  FILE *rd;
  struct stat fs;
  uint8_t *framedata;

  rd=fopen("frames.bin", "rb");
  if (rd==NULL) return 1;

  fstat(fileno(rd), &fs);
  framedata=malloc(fs.st_size);

  if (framedata!=NULL)
  {
    uint8_t frame;
    uint16_t start;
    uint16_t end;

    fread(framedata, fs.st_size, 1, rd);
    fclose(rd);

    // Process it
    for (frame=0; frame<(NUMFRAMES-1); frame++)
    {
      start=(framedata[frame*2]);
      start=((framedata[(frame*2)+1]<<8)+start);

      // Check for valid pointer
      if (start<0xff00)
      {
        uint8_t width, height;
        uint16_t offs;
        uint8_t y;

        width=framedata[(NUMFRAMES*2)+start]*4;
        height=framedata[(NUMFRAMES*2)+start+1];

        // Calculate where the end should be given the width and height
        end=start+2+((width*height)/8)-1;

        printf("%d [%.2x] : 0x%.4x .. 0x%.4x (%dx%d)\n", frame, frame, start, end, width, height);

        // Decode the framedata
        offs=0;
        for (y=0; y<height; y++)
        {
          drawbin_width(&framedata[(NUMFRAMES*2)+start+HEADERBYTES+offs], width);
          offs+=(width/8);
        }

        printf("\n");
      }
      else
        printf("%d [%.2x] : 0x%.4x\n", frame, frame, start); // Show where null frames are
    }

    free(framedata);
  }
  else
  {
    fclose(rd);

    return 1;
  }

  return 0;
}
