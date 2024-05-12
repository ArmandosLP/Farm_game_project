extends PanelContainer
class_name Item_grid_cell

var id : int
@onready var textureRect = %TextureRect
var inventory

func _process(_delta):
	if Input.is_action_just_pressed("Mouse_left_click") and mouse_inside:
		InventorySystem.click(inventory,id)
		update()

var mouse_inside = false
func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func update():
	if inventory.items[id] != null:
		textureRect.texture = inventory.items[id].texture
	else:
		textureRect.texture = null
