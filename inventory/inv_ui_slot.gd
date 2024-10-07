extends Button

@onready var container: CenterContainer = $CenterContainer

var itemPanel: ItemPanel

func insert(ip: ItemPanel):
	itemPanel = ip
	container.add_child(itemPanel)
