extends PanelContainer
class_name Item_grid_cell_displayer

const TILE_0062  = preload("res://Conversation_System/Sprites/tile_0062.png")
const TILE_0062B = preload("res://Conversation_System/Sprites/tile_0062B.png")


var id:int #Posicion del contenedor en la que se encuentra el hueco
var inventory:Inventory #Inventario al que pertenece el contenido mostrado
var mouse_inside:bool = false

@onready var textureRect = %TextureRect
@onready var amount = %Amount
@onready var nine_patch_rect = %NinePatchRect


func _input(event):
	if event is InputEventMouse and mouse_inside:
		if event.is_action_pressed("Mouse_left_click"):
			InventoryManager.left_click(inventory,id)
			update(inventory)
		elif event.is_action_pressed("Mouse_right_click"):
			InventoryManager.right_click(inventory,id)
			update(inventory)


func update(_inventory : Inventory): #Recibe un inventario para actualizar sus datos
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


func _on_mouse_entered():
	nine_patch_rect.texture = TILE_0062B
	mouse_inside = true
	if inventory.items[id] != null:
		InventoryManager.description_displayer.show_desc(inventory.items[id])


func _on_mouse_exited():
	InventoryManager.description_displayer.hide_desc()
	nine_patch_rect.texture = TILE_0062
	mouse_inside = false


func _on_draw(): #Comprueba si el raton esta dentro al ser dibujado
	if Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		_on_mouse_entered()


func _on_hidden(): #Al ocultarse, si el raton esta dentro, deja de estar seleccionado
	if mouse_inside:
		_on_mouse_exited()


func check_mouse_inside():
	if Rect2(Vector2(), size).has_point(get_local_mouse_position()) and InventoryManager.get_visibility():
		_on_mouse_entered()
