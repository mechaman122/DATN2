extends Area2D
class_name ArmorItem

var player_ref: Node2D
var tween: Tween = null

@onready var sprite = get_node("Sprite2D")
@export var armor_stats: ArmorStats:
	set(value):
		armor_stats = value
		match value.type:
			"Swift": armor_stats.modifiers["speed"] = 0.2
			"Light": armor_stats.modifiers["speed"] = 0.1
			"Medium": armor_stats.modifiers["speed"] = -0.1
			"Heavy": armor_stats.modifiers["speed"] = -0.3


func _ready() -> void:
	#if is_on_floor == true && get_parent() == get_tree():
		#$CollisionShape2D.disabled = false
	if armor_stats != null:
		sprite.texture = armor_stats.texture
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_ref is Player and Input.is_action_just_pressed("ui_interact"):
		if SavedData.equipped_armor == null:
			player_ref.equip_armor(self)
		else:
			player_ref.equip_different_armor(self)
		#queue_free()
		activate_passive(player_ref)
		$CollisionShape2D.disabled = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_ref = body
		Popups.item_popup(Rect2i(Vector2i(global_position), Vector2i(0,0)), armor_stats)


func _on_body_exited(body: Node2D) -> void:
	player_ref = null
	Popups.item_hidepopup()


func interpolate_pos(init_pos: Vector2, final_pos: Vector2) -> void:
	position = init_pos
	tween = create_tween()
	tween.tween_property(self, "position", final_pos, 0.8).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.connect("finished", _on_tween_completed)


func _on_tween_completed():
	$CollisionShape2D.disabled = false


func activate_passive(target):
	if armor_stats.passive != null:
		armor_stats.passive.activate(target, armor_stats.passive.value)
