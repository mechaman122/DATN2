extends TextureProgressBar

@export var attribute_to_count: Node2D
@export var under_texture: Texture2D
@export var progress_texture: Texture2D

@onready var damage_bar: TextureProgressBar = get_node("DamageBar")
@onready var damage_timer: Timer = get_node("DamageTimer")

#var curr = 10
#var max = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture_progress = progress_texture
	damage_bar.texture_under = under_texture
	
	damage_bar.value = self.value

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_interact"):
		#curr -= 1
		#change_value(curr, max)


func _on_damage_timer_timeout() -> void:
	damage_bar.value = self.value


func change_value(curr: int, max: int):
	self.value = curr
	if curr - max < 0:
		damage_timer.start()
	else: 
		damage_bar.value = self.value


func change_max_value(max: int):
	self.max_value = max
	damage_bar.value = self.value 
