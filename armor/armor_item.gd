extends Area2D
class_name ArmorItem

var touch_body: Node2D
var passives: Dictionary
@onready var sprite = get_node("Sprite2D")
@export var armor_stats: ArmorStats = null:
	set(value):
		armor_stats = value
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	#for i in armor_stats.stats:
		#stats2[i] = armor_stats.stats[i]
	#for i in armor_stats.passives:
		#passives[i] = armor_stats.passives[i]
		#
	if armor_stats != null:
		sprite.texture = armor_stats.texture
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if touch_body is Player and Input.is_action_just_pressed("ui_interact"):
		if SavedData.equipped_armor == null:
			touch_body.equip_armor(self.armor_stats)
		else:
			touch_body.equip_different_armor(SavedData.equipped_armor, self.armor_stats)
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		touch_body = body
		Popups.item_popup(Rect2i(Vector2i(global_position), Vector2i(0,0)), armor_stats)


func _on_body_exited(body: Node2D) -> void:
	touch_body = null
	Popups.item_hidepopup()
