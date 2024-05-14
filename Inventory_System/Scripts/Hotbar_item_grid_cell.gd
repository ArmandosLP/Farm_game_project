extends PanelContainer

@onready var nine_patch_rect = %NinePatchRect
@onready var textureRect = %TextureRect
@onready var amount = %Amount

var inventory : Inventory
var id : int

func _ready():
	update()

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
