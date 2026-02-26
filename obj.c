#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

int main()
{
  FILE *rd;
  struct stat fs;
  uint8_t *filedata;
  size_t c, i, j, k, l, m;

  i=0x52c0; // room no
  j=0x5346; // x pos
  k=0x53cc; // y pos
  l=0x5452; // attrib
  m=0x54d8; // frame no

  rd=fopen("tid2.raw", "rb");
  if (rd==NULL) return 1;

  fstat(fileno(rd), &fs);
  filedata=malloc(fs.st_size);

  if (filedata!=NULL)
  {
    fread(filedata, fs.st_size, 1, rd);
    fclose(rd);

    for (c=0; c<134; c++)
    {
      printf("%d,%d,%d,%d,%d\n", filedata[i+c], filedata[j+c], filedata[k+c], filedata[l+c], filedata[m+c]);
    }
  }
  else
  {
    fclose(rd);

    return 1;
  }

  return 0;
}
