#ifndef _ENEMY_SHIP_H
#define _ENEMY_SHIP_H

#include "ship.h"

/** 
 * Ship controlled by computer
 */
class EnemyShip: public Ship {
private:
	int mMoves;
	int mPower;
	int mChaoticLevel;
	
public:
	EnemyShip(int x, int y, int power);	
	bool can_shoot();
	bool isComputer();
	void random_move();
	void change_direction();
	int getPower();
};

#endif
