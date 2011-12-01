
class Missile : public Entity {
public:
	Missile() {
		x = WIDTH+1;
	}

	void draw() {
		GLCD.DrawHLine(x,y, ENTITY_WIDTH);
	}

	void tick() {
		if (canFire()) return;
		translate(2,0);
		draw();
	}

	void fire(int x, int y){
		if (canFire())
			setPosition(x,y);
	}

	void destroyIfHit(Entity * entity) {
		if (canFire()) return;
		if (collides(entity)) {
			x = WIDTH+1;
			entity->destroy();
		}
	}

	boolean canFire() {
		return ((this->x + ENTITY_WIDTH)  >= (WIDTH -2)  );
	}
};
