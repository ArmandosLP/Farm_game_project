extends Control
class_name Description_displayer

@onready var item_name = %ItemName
@onready var item_description = %ItemDescription
@onready var item_price = %ItemPrice

var showing : bool = false

func _process(delta):
	position = get_global_mouse_position()
	if modulate.a < 1 and showing:
		modulate.a += 12 * delta
	elif modulate.a > 0 and !showing:
		modulate.a -= 9 * delta


func show_desc(item : Item):
	if InventoryManager.cursor_item == null:
		visible = true
		showing = true
		item_name.text = item.name
		item_description.text = item.description
		item_price.text = str(item.price)
	
	
func hide_desc():
	showing = false
	
