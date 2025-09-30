#ifndef GAME_H
#define GAME_H

#define WINDOW_H 600
#define WINDOW_W 800
#define FRAME_TICKS 50

void sim_init();
void app();
void sim_flush();
int sim_get_rand();
void sim_exit();
void sim_draw_color(int x, int y, int argb);
int sim_get_color(int x, int y);

#endif