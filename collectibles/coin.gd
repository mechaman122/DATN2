extends Collectible

func active_effect(body):
	SoundManager.play_sfx("coin_sfx")
	SavedData.coins += 1
