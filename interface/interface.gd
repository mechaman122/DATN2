extends CanvasLayer
@onready var health_bar = $LifeBar/TextureProgressBar
@onready var damage_bar = $LifeBar/TextureProgressBar/DamageBar
@onready var health = get_parent().get_node("Adventurer/Health")
@onready var player = get_parent().get_node("Adventurer")
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = 100
	damage_bar.value = 100
	health.max_health_changed.connect(_on_max_health_changed)
	health.health_changed.connect(_on_health_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_health_changed(diff: int) -> void:
	# change the percentage of the health bar
	health_bar.value = (float(health.health) / float(health.max_health)) * 100
	
	if diff < 0:
		player.health_changed = true
		timer.start()
	else:
		damage_bar.value = health_bar.value

func _on_max_health_changed(diff: int) -> void:
	# change the percentage of the health bar
	health_bar.value = (float(health.health) / float(health.max_health)) * 100
	damage_bar.value = health_bar.value

func _on_timer_timeout() -> void:
	damage_bar.value = health_bar.value
