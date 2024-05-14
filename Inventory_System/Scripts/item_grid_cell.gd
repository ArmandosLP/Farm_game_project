extends PanelContainer
class_name Item_grid_cell_displayer

const TILE_0062  = preload("res://Conversation_System/Sprites/tile_0062.png")
const TILE_0062B = preload("res://Conversation_System/Sprites/tile_0062B.png")

var inventory : Inventory
var id : int

@onready var textureRect = %TextureRect
@onready var nine_patch_rect = %NinePatchRect
@onready var amount = %Amount

func _process(_delta):
	if mouse_inside:
		if Input.is_action_just_pressed("Mouse_left_click"):
			InventorySystem.left_click(inventory,id)
			update()
		elif Input.is_action_just_pressed("Mouse_right_click"):
			InventorySystem.right_click(inventory,id)

var mouse_inside = false
func _on_mouse_entered():
	nine_patch_rect.texture = TILE_0062B
	if inventory.items[id] != null:
		InventorySystem.show_description(inventory,id)
	mouse_inside = true

func _on_mouse_exited():
	nine_patch_rect.texture = TILE_0062
	InventorySystem.hide_description()
	mouse_inside = false

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
		
func is_mouse_inside():
	return Rect2(Vector2(), size).has_point(get_local_mouse_position())


