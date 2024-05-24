extends PanelContainer
class_name Hotbar_item_cell

@onready var nine_patch_rect = %NinePatchRect
@onready var textureRect = %TextureRect
@onready var amount = %Amount
@onready var selector = %Selector

var inventory : Inventory
var id : int


func select():
	selector.visible = true


func unselect():
	selector.visible = false


func update(_inventory:Inventory):
	inventory = _inventory
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


func _on_draw():
	update(inventory)

