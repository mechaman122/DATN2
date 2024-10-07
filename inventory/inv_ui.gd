extends Control

var is_open = false

@onready var inv: Inv = preload("res://inventory/player_inv.tres")
@onready var itemPanelClass = preload("res://inventory/inv_ui_item_panel.tscn")
@onready var inv_slots: Array = $inv_UI/GridContainer.get_children()

func _ready(): 
	inv.update.connect(update_slots)
	connectSlots()
	update_slots()
	close()

func connectSlots():
	for slot in inv_slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_inventory"):
		if is_open:
			close()
		else:
			open()
	elif Input.is_action_just_released("ui_inventory_1"):
		inv.use_item_at_index(0)

func update_slots():
	for i in range(min(inv.slots.size(), inv_slots.size())):
		var inventorySlot: InvSlot = inv.slots[i]

		# if !inventorySlot.item: continue

		var itemPanel: ItemPanel = inv_slots[i].itemPanel
		if !itemPanel:
			itemPanel = itemPanelClass.instantiate()
			inv_slots[i].insert(itemPanel)
			
		itemPanel.inventorySlot = inventorySlot
		itemPanel.update()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false

func onSlotClicked(slot):
	pass
