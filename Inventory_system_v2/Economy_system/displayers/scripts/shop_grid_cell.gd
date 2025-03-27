extends PanelContainer

const TILE_0011 = preload("res://Inventory_system_v2/Economy_system/sprites/tile_0011.png")
const TILE_0011B = preload("res://Inventory_system_v2/Economy_system/sprites/tile_0011B.png")

@onready var grid_cell_rect = %GridCellRect

@onready var nombre = %Nombre
@onready var item_texture = %ItemTexture
@onready var price = %Price


var id:int
var shop:Shop

var mouse_inside:bool = false


func update(_shop:Shop):
	shop = _shop
	item_texture.texture = shop.selling_items[id].item.texture
	nombre.text = shop.selling_items[id].item.name
	price.text = str(shop.selling_items[id].item.price * _shop.selling_items[id].price_modifier)


func _input(event):
	if event is InputEventMouse and mouse_inside:
		if event.is_action_pressed("Mouse_left_click"):
			EconomyManager.left_click(shop,id)
		elif event.is_action_pressed("Mouse_right_click"):
			EconomyManager.right_click(shop,id)


func _on_mouse_entered():
	grid_cell_rect.texture = TILE_0011B
	mouse_inside = true


func _on_mouse_exited():
	grid_cell_rect.texture = TILE_0011
	mouse_inside = false


func _on_draw(): #Comprueba si el raton esta dentro al ser dibujado
	if Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		_on_mouse_entered()


func _on_hidden(): #Al ocultarse, si el raton esta dentro, deja de estar seleccionado
	if mouse_inside:
		_on_mouse_exited()
