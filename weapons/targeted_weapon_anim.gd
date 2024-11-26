extends WeaponAnimation

@export var amount: int = 1
var projectile_list = []

func shoot(weapon_type: String = "Bow", spd: int = 500, offset: float = 0) -> void:
	var THUNDER = load("res://weapons/projectile/thunder.tscn")
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	
	if enemies.size() == 0:
		return
		
	for i in range(amount):
		var enemy = enemies.pick_random()
		
		var projectile = THUNDER.instantiate()
		projectile.speed = 0
		
		projectile.position = enemy.position
		#projectile.sprite.texture = projectile_sprite.texture
		projectile_list.append(projectile)
		
		set_hitbox(projectile.get_node("Hitbox"))
		add_child(projectile)
	
	await get_tree().create_timer(0.5).timeout
	for i in range(projectile_list.size()):
		var temp = projectile_list.pop_front()
		if is_instance_valid(temp):
			temp.queue_free()
