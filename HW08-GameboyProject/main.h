#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

// TODO: Create any necessary structs

/*
* For example, for a Snake game, one could be:
*
* struct snake {
*   int heading;
*   int length;
*   int row;
*   int col;
* };
*
* Example of a struct to hold state machine data:
*
* struct state {
*   int currentState;
*   int nextState;
* };
*
*/

struct sprite {
    int x;
    int y;
    int prevX;
    int prevY;
    int width;
    int height;
};

struct shark {
    int x;
    int y;
    int width;
    int height;
};

struct treasure {
    int x;
    int y;
    int width;
    int height;
};


#endif
