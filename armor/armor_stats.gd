extends Item
class_name ArmorStats


@export_enum("Swift", "Light", "Medium", "Heavy")
var type: String = "Light"
@export var bonus_armor: int
@export var bonus_attribute: String
@export var bonus_attribute_value: int
