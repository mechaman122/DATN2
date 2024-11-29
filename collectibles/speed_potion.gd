extends Collectible

func active_effect(body):
	SoundManager.play_sfx("fast_forward_sfx")
	super.active_effect(body)
	
