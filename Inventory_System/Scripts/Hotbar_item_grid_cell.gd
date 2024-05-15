extends PanelContainer
class_name Hotbar_grid_cell

@onready var nine_patch_rect = %NinePatchRect
@onready var textureRect = %TextureRect
@onready var amount = %Amount
@onready var selector = %Selector

var inventory : Inventory
var id : int

func update():
	if inventory.items[id] != null:
		textureRect.texture = inventory.items[id].texture
		amount.text = str(inventory.amount[id])
		if inventory.amount[id] <= 1:
			amount.visible = false
		else:
			amount.visible = true
	else:
		textureRect.texture = null
		amount.visible = false
