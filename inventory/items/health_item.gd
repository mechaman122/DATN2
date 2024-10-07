extends InvItem

class_name HealthItem

@export var health_change: int = 1

func use(player: Player) -> void:
	var health = player.get_node("Health")
	health.health += health_change
