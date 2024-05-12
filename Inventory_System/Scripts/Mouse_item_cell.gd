extends PanelContainer
class_name Mouse_item_cell

@onready var texture_rect = %TextureRect

func _process(_delta):
	global_position = get_global_mouse_position() - size / 2 * get_parent().scale

func update():
	if InventorySystem.cursor_item != null:
		texture_rect.texture = InventorySystem.cursor_item.texture
	else:
		texture_rect.texture = null
