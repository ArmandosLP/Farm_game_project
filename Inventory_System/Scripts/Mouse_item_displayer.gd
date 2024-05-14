extends PanelContainer
class_name Mouse_item_displayer

@onready var texture_rect = %TextureRect
@onready var amount = %Amount

func _ready():
	update()

func _process(_delta):
	global_position = get_global_mouse_position() - size / 2 * get_parent().scale

func update():
	if InventorySystem.cursor_item != null:
		texture_rect.texture = InventorySystem.cursor_item.texture
		amount.text = str(InventorySystem.cursor_amount)
		if InventorySystem.cursor_amount <= 1:
			amount.visible = false
		else:
			amount.visible = true
	else:
		texture_rect.texture = null
		amount.visible = false
