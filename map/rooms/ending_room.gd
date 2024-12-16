extends Room

func _ready() -> void:
	super._ready()
	EventBus.all_enemy_defeated.connect(_on_all_enemy_defeated)
	$Statirs.get_node("CollisionShape2D").set_deferred("disabled", true)
	$Statirs.get_node("GPUParticles2D").emitting = false
	$Statirs.position =  coord * 16 + size * 8

#func _process(delta: float) -> void:
	##if enemy_container.get_child_count() == 0:
	#$Statirs.position =  coord * 16 + size * 8
func _on_all_enemy_defeated():
	$Statirs.get_node("CollisionShape2D").set_deferred("disabled",false)
	$Statirs.get_node("GPUParticles2D").emitting = true
