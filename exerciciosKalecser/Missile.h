
class Missile : public Entity {
public:
	void draw() {
		GLCD.DrawHLine(x,y, ENTITY_WIDTH);
	}

	void tick() {
		translate(2,0);
		draw();
	}

	void fire(int x, int y){
		boolean canFire = ((this->x + ENTITY_WIDTH)  >= (WIDTH -2)  );
		if (canFire)
			setPosition(x,y);
	}

};
