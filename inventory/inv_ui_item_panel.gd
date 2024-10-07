extends Panel

class_name ItemPanel

@onready var item_disp: Sprite2D = $item_display
@onready var amount_label: Label = $Label

var inventorySlot: InvSlot

func update():
	if !inventorySlot.item:
		item_disp.visible = false
		amount_label.visible = false
		return
	item_disp.texture = inventorySlot.item.texture
	item_disp.visible = true
	
	if inventorySlot.amount > 1:
		amount_label.visible = true
		amount_label.text = str(inventorySlot.amount)
	else:
		amount_label.visible = false
