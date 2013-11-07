#include "axp_decoder.h"

#include <stdio.h>
#include <string.h>

#define BUFF_SIZE 16

#define is_hex_digit(s) \
    (((s)>='0' & (s)<='9') || ((s)>='a' & (s)<='f') || ((s)>='A' & (s)<='F'))

typedef struct {
    char *sign_seq;
    int  length;
    int  control;
} sign;

sign *Sign(const char *sign_s, int control) {
    sign *s =(sign*)malloc(sizeof(sign));
    s->length = strlen(sign_s);
    s->control= control;
    return s;
}

int hex2int(char c) {
    if (!is_hex_digit(c))
        return 0;
    if ('0' <= c & c <= '9')
        return c-'0';
    else
        return 10+c-'a';
}

char *hex2asciix(const char *s) {
    char *asciix = (char *)malloc(sizeof(char)*(strlen(s)+1));
    char i1, i2;
    int j = 0;
    if (strlen(s)%2 != 0)
        return 0;
    for (int i=0; i<strlen(s); i+=2) {
        if (!is_hex_digit(s[i]) || !is_hex_digit(s[i+1]))
            return 0;
        i1 = hex2int(s[i]);
        i2 = hex2int(s[i+1]);
        asciix[j++] = i1*16+i2;
    }
    asciix[j] = 0;
    return asciix;
}
        

FILE *stream;

void init() {
	stream = NULL;
}

long file_byte_size(FILE *file) {
	long size;
	fseek(file, 0L, SEEK_END);
	size = ftell(file);
	fseek(file, 0L, SEEK_SET);
	return size;
}

status open(const char *path, const char *mode) {
	file = fopen(path, mode);
	if (!file) {
		return FAIL;
	}
	return SUCCESS;
}

long binstr_match(const char *tgt, FILE *stream) {
	char buff[strlen(tgt)+1];
	long pos = ftell(stream);
	while (fgets(buff, strlen(tgt)+1, stream) != NULL) {
		if (0 == strcmp(buff, tgt)) {
			return pos;
		}
		pos++;
		fseek(stream, pos, SEEK_SET);
	}
    return pos;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        return -1;
    }
    stream = open(argv[1], "r");
    
    return 0;
}
