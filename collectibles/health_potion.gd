extends Collectible
	

func active_effect(body):
	SoundManager.play_sfx("bottle_drink_sfx")
	body.health.health += 1
