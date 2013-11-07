#ifndef _AXP_DECODER_H
#define _AXP_DECODER_H

#define NAME_LEN 64
#define SRC_LEN 64
#define ID_LEN  64
#define UNIT_LEN 0x1c
#define RESERVED1_LEN 8
#define RECIEVER_LEN 24
#define SENDER_LEN 24
#define CURVE_DESCRITPION_LEN 0x80
#define RESERVED2_LEN 0x4c

typedef char byte;

typedef enum {UP, DOWN} direction;

typedef enum {SUCCESS, FAIL} status;

typedef struct {
	char name[NAME_LEN];
        char src[SRC_LEN];
	char id[ID_LEN];
	char unit[UNIT_LEN];
        short point_by_depth;
        byte  reserved1[RESERVED1_LEN];
	float time_interval;
	float time_delay;
	short point_per_frame;
        short array_count;
	int   frame_byte_size;
	byte  reciever[RECIEVER_LEN];
	byte  sender[SENDER_LEN];
	float distance_of_reciever_to_reciever;
	float distance_of_sender_to_reciever;
	char  curve_description[CURVE_DESCRITPION_LEN];
	byte  reserved2[RESERVED2_LEN];
} axp_curve_header;


int get_curve_count();
axp_curve_header* get_curve_header(int index);
int get_point_count(int curve_index);
byte* get_curve_data(int curve_index, int point_index);
int get_point_byte_count(int curve_index);
int get_point_per_depth(int curve_index);
int get_depth(int position);
int get_base_sample_space();
direction get_direction();

#endif
