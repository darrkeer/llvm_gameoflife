#include "game.h"
#include <stdio.h>

#define ALIVE 0xFFFFFFFF
#define DEAD  0xFF000000

static char data[2][WINDOW_H * WINDOW_W];
static int t;

char is_alive(int x, int y) {
    return data[t][y * WINDOW_H + x];
}

void set_alive(int x, int y, char alive) {
    data[!t][y * WINDOW_H + x] = alive;
}

void generate_field() {
    for (int x=0; x<WINDOW_W; ++x) {
        for (int y=0; y<WINDOW_H; ++y) {
            if (sim_get_rand() % 5 > 1) {
                set_alive(x, y, 1);
            } else {
                set_alive(x, y, 0);
            }
        }
    }
}

int calc_siblings(int x, int y) {
    int cnt = 0;
    for (int dx=-1; dx<=1; ++dx) {
        for (int dy=-1; dy<=1; ++dy) {
            int nx = x + dx;
            int ny = y + dy;
            if(!(0 <= nx && nx < WINDOW_W) || !(0 <= ny && ny < WINDOW_H) || nx == x && ny == y) {
                continue;
            }
            if(is_alive(nx, ny)) {
                ++cnt;
            }
        }
    }
    return cnt;
}

void update_field() {
    for(int x=0; x<WINDOW_W; ++x) {
        for(int y=0; y<WINDOW_H; ++y) {
            int cnt = calc_siblings(x, y);
            if(is_alive(x, y) == 1) {
                if(2 <= cnt && cnt <= 3) {
                    set_alive(x, y, 1);
                } else {
                    set_alive(x, y, 0);
                }
            } else {
                if(cnt == 3) {
                    set_alive(x, y, 1);
                } else {
                    set_alive(x, y, 0);
                }
            }
        }
    }
}

void paint_field() {
    for(int x=0; x<WINDOW_W; ++x) {
        for(int y=0; y<WINDOW_H; ++y) {
            if(is_alive(x, y)) {
                sim_draw_color(x, y, ALIVE);
            } else {
                sim_draw_color(x, y, DEAD);
            }
        }
    }
}

void app() {
    generate_field();
    while(1) {
        t = !t;
        update_field();
        paint_field();
        sim_flush();
    }
}