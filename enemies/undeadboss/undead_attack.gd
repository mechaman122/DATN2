extends UndeadBossState
var move_set = ["1","1","2"]

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	combo()
 
func attack(move = "1"):
	undead.animation_player.play("attack_" + move)
	await undead.animation_player.animation_finished
 
func combo():
	for i in move_set:
		await attack(i)
	combo()
 
func physics_update(delta: float) -> void:
	var dir = player.global_position - undead.global_position
	
	if dir.x < 0:
		undead.hitbox2.position = Vector2(-13, 10)
		undead.hitbox.position = Vector2(-13, 10)
		undead.animated_sprite.flip_h = true
	elif dir.x > 0:
		undead.hitbox2.position = Vector2(13, 10)
		undead.hitbox.position = Vector2(13, 0)
		undead.animated_sprite.flip_h = false
	
	if dir.length() > 40:
		finished.emit(FOLLOW)
	if undead.health.health <= 0:
		finished.emit(DEATH)
