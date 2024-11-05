extends Area2D
class_name ArmorItem

@onready var sprite = get_node("Sprite2D")
@export var armor_stats: ArmorStats = null:
	set(value):
		armor_stats = value
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if armor_stats != null:
		sprite.texture = armor_stats.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.equip_armor(self.armor_stats)
		queue_free()
