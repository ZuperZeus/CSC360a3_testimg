#include <stdio.h>
#include <stdint.h>
#include <arpa/inet.h>
#define BLOCK_SIZE 1024
#define BLOCK_COUNT 30720
#define FAT_START_BLOCK 1111
#define FAT_BLOCK_COUNT BLOCK_COUNT/BLOCK_SIZE
#define ROOT_START_BLOCK 5
#define ROOT_BLOCK_COUNT 4
int main(int argc, char * argv[])
{
	//Buffers
	uint16_t buf16; 
	uint32_t buf32; 
	uint8_t zero=0;

	//File is of size BLOCK_SIZE*BLOCK_COUNT
	FILE *file=fopen("image.img","r+");
	for(int i=0;i<BLOCK_SIZE*BLOCK_COUNT;i++)
		fwrite(&zero,1,1,file);
	fseek(file,0,SEEK_SET);

	//Title
	fwrite("IMGFILE\0",8,1,file);

	buf16=htons(BLOCK_SIZE);	fwrite(&buf16,2,1,file);
	buf32=htonl(BLOCK_COUNT);	fwrite(&buf32,4,1,file);
	buf32=htonl(FAT_START_BLOCK);	fwrite(&buf32,4,1,file);
	buf32=htonl(FAT_BLOCK_COUNT);	fwrite(&buf32,4,1,file);
	buf32=htonl(ROOT_START_BLOCK);	fwrite(&buf32,4,1,file);
	buf32=htonl(ROOT_BLOCK_COUNT);	fwrite(&buf32,4,1,file);

	//Root linked list, the start is always ROOT_START_BLOCK,
	//and the end is always 0xffffffff,
	//however, you can modify the values in between, as long as the list is of length ROOT_BLOCK_COUNT+1
	int rootaddressarr[ROOT_BLOCK_COUNT+1]={ROOT_START_BLOCK,7,9,11,0xffffffff};
	for(int i=0;i<ROOT_BLOCK_COUNT;i++)
	{
		fseek(file,FAT_START_BLOCK*BLOCK_SIZE+rootaddressarr[i]*4,SEEK_SET);
		buf32=htonl(rootaddressarr[i+1]);	fwrite(&buf32,4,1,file);
	}
	fclose(file);
}

