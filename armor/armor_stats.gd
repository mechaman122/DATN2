extends Item
class_name ArmorStats


@export_enum("Swift", "Light", "Medium", "Heavy")
var type: String

@export var armor: int
@export var passive: Passive
@export var modifiers: Dictionary = {
	"speed": 0.0
}
