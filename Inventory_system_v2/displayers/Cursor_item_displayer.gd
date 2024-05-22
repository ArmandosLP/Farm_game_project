extends PanelContainer
class_name Cursor_item_displayer

@onready var texture_rect = %TextureRect
@onready var amount_text = %Amount_text

func _ready():
	texture_rect.texture = null
	amount_text.text = ""

func _process(_delta):
	global_position = get_global_mouse_position() - size / 2 * get_parent().scale
	
func update():
	var item:Item = InventoryManager.cursor_item
	var amount:int = InventoryManager.cursor_amount
	if item != null:
		visible = true
		texture_rect.texture = item.texture
		if amount > 1:
			amount_text.text = str(amount)
			amount_text.visible = true
		else:
			amount_text.visible = false
	else:
		visible = false
