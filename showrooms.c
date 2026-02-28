#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define NUMROOMS 255

int main()
{
  FILE *rd;
  struct stat fs;
  uint8_t *roomdata;

  rd=fopen("roomdata.bin", "rb");
  if (rd==NULL) return 1;

  fstat(fileno(rd), &fs);
  roomdata=malloc(fs.st_size);

  if (roomdata!=NULL)
  {
    int room;

    fread(roomdata, fs.st_size, 1, rd);
    fclose(rd);

    // Process it
    for (room=0; room<(NUMROOMS-1); room++)
    {
      int start, end;

      start=(roomdata[room*2]);
      start=((roomdata[(room*2)+1]<<8)+start);

      end=(roomdata[(room+1)*2]);
      end=((roomdata[((room+1)*2)+1]<<8)+end);

      if (end!=start)
      {
        int i=0;

        printf("%d : 0x%.4x to 0x%.4x (len %d)\n", room, start, end-1, end-start);
        printf("{%.2x %.2x}\n", roomdata[(NUMROOMS*2)+i], roomdata[(NUMROOMS*2)+i+1]);

        printf("  ");

        for (i=start+2; i<end; i+=3)
        {
          printf("[%d ", roomdata[(NUMROOMS*2)+i]); // frameNum
          printf("%dx%d", (roomdata[(NUMROOMS*2)+i+1]&0x7f)*2, roomdata[(NUMROOMS*2)+i+2]); // frameX,frameY
          if (!(roomdata[(NUMROOMS*2)+i+1] & 0x80))
          {
            printf(" 0x%.2x]", roomdata[(NUMROOMS*2)+i+3]); // frameAttr
            i++;
          }
          else
            printf("]");
        }

        printf("\n");
      }
      else
        printf("%d : 0x%.4x to 0x%.4x (len %d) empty room\n", room, start, end, end-start);
    }

    free(roomdata);
  }
  else
  {
    fclose(rd);

    return 1;
  }

  return 0;
}
