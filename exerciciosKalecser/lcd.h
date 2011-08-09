#include <glcd.h>
#include "Manche.h"
#include "Dashboard.h"

#define WIDTH 128
#define HEIGHT 64

#define ENTITY_WIDTH 6
#define ENTITY_HEIGHT 6

class Entity {
protected:
	int x, y;
	
public:
	Entity() : x(0), y(0) {
	}
	
	virtual void setX(int newX) {
		if(isOutOfScreenX(newX)) {
			return;
		}
		x = newX;
	}
	
	boolean isOutOfScreenX(int newX) {
		if( newX >= WIDTH - ENTITY_WIDTH ) {
			return true;
		}
		
		if (newX < 0) {
			return true;
		}
		return false;
	}
	
	virtual void setY(int newY) {
		if( newY >= HEIGHT - ENTITY_HEIGHT ) {
			return;
		}
		
		if (newY < 0){
			return;
		}
		
		y = newY;
	}
	
	void setPosition(int newX, int newY) {
		setX(newX);
		setY(newY);
	}
	
	void translate(int deltaX, int deltaY){
		setPosition(x + deltaX, y + deltaY);
	}

	virtual void draw() = 0;
	
	virtual void tick() = 0;
	
	boolean collides(Entity* entity) {
		int dx = x - entity->x;
		int dy = entity->y - y;
		return dx > ENTITY_WIDTH * -1  && dx < ENTITY_WIDTH && dy > ENTITY_HEIGHT * -1  && dy < ENTITY_HEIGHT ;
	}
};

#include "Missile.h"

class Plane : public Entity {
public:
	Missile * missile;
	Manche* manche;
	Dashboard* dashboard;
	int fuel;
	
	Plane(){
		fuel = 180;
		manche = new Manche();
		manche->begin();
		dashboard = new Dashboard();
		dashboard->attach(2,3);
		missile = new Missile();
	}
	
	void center() {
		setPosition(WIDTH/2-ENTITY_WIDTH/2,HEIGHT/2-ENTITY_HEIGHT/2);
	}
	
	void moveLeft() {
		translate(0,-1);
	}
	void moveRight() {
		translate(0,1);
	}

	void moveForward() {
		translate(2,0);
	}
	void moveBackward() {
		translate(-1,0);
	}
	
	boolean isDead(){
		return fuel <= 0;
	}
	
	virtual void tick(){
		translate(-1,0);
		
		dashboard->setFuel(fuel);
		
		manche->update();
	
		if (manche->isLeft()){
			moveLeft();
			fuel--;
		}
		
		if (manche->isRight()){
			moveRight();
			fuel--;
		}
		
		if (manche->isForward()){
			moveForward();
			fuel--;
		}
		
		if (manche->isBackward()){
			moveBackward();
			fuel--;
		}

		if (fuel < 80){
			tone(12, 440*3, 100);
		}

		
		missile->fire(x+ENTITY_WIDTH, y+ENTITY_HEIGHT/2);
	        missile->tick();
	}
	
	void setdashboardSpeed(int speed){
		dashboard -> setSpeed(speed);
	}
	
	int getAcceleration(){
		return manche->getAcceleration() * -1;
	}
	
	virtual void draw() {
		GLCD.DrawLine(x,y,x+6,y+3);
		GLCD.DrawLine(x+6,y+3,x,y+6);
		GLCD.DrawLine(x,y,x,y+6);
	}
	
	void fuelIfNecessary(Entity *entity) {
		if( collides( entity ) ) {
			fuel += 5;
			if(fuel>180) {
				fuel = 180;
			}
		}
	}
	
	void testRock(Entity * entity) {
		if( collides( entity ) ) {
			fuel = 0;
			dashboard->setFuel(fuel);
		}
	}
	
};

class Rock : public Entity {
	
public:
	
	Rock(){
		initialize();
	}
	
	virtual void draw() {
		if(isOutOfScreenX(x)) {
			return;
		}
		GLCD.FillRect(x,y, ENTITY_WIDTH, ENTITY_HEIGHT );
	}
	
	virtual void tick(){
		if(x==0) {
			initialize();
		}
		translate(-1,0);
	}
	
	void setX(int newX) {	
		if (newX < 0) {
			return;
		}
		x = newX;
	}
	
private:
	
	void initialize() {
		setPosition(121+ random(0,200),random(0,HEIGHT - 1 - ENTITY_HEIGHT));
	}
	
};

class Fuel : public Rock {
	
public:
	
	
	virtual void draw() {
		if(isOutOfScreenX(x)) {
			return;
		}
		Rock::draw();
		GLCD.DrawHLine(x+1, y + 1,ENTITY_WIDTH - 2, WHITE );
		GLCD.DrawVLine(x+3, y + 1, 2, WHITE );
		GLCD.DrawVLine(x+5, y + 1, 4, WHITE );
	}
};

