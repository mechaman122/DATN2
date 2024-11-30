extends Projectile

@onready var effect = $Explosion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	$Hitbox.set_disabled(true)


func _on_impact(_body: Node2D) -> void:
	$Hitbox.set_disabled(false)
	get_tree().create_timer(0.1).connect("timeout", _disable_hitbox)
	
	effect.emitting = true
	sprite.visible = false
	speed = 0.0
	timer.start(0.6)

func _disable_hitbox():
	$Hitbox.set_disabled(true)


func _on_timer_timeout() -> void:
	queue_free()
