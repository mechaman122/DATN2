extends Panel

@onready var item_disp: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_label: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	if !slot.item:
		item_disp.visible = false
		amount_label.text = ""
	else:
		item_disp.texture = slot.item.texture
		item_disp.visible = true
		if slot.amount > 1:
			amount_label.text = str(slot.amount)
