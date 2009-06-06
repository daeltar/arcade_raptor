#ifndef _PLAYER_SHIP_H
#define _PLAYER_SHIP_H

#include "ship.h"

using namespace std;

/** 
 * Ship controlled by player
 */ 
class PlayerShip: public Ship {
private:
  int mKills;
  
public:
  PlayerShip();
  bool can_shoot();
  bool isComputer();
};

#endif
