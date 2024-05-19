extends Control
class_name Continer_Displayer

const INVENTORY_DISPLAYER = preload("res://Inventory_System/Scenes/Inventory_displayer.tscn")

@onready var displayer_grid = %displayer_grid

var oppened_inventory_displayer : Inventory_Displayer
var player_inventory_displayer : Inventory_Displayer

func _ready():
	visible = false
	player_inventory_displayer = InventorySystem.player_inventory_displayer

func close_continer():
	if oppened_inventory_displayer != null:
		visible = false
		displayer_grid.remove_child(oppened_inventory_displayer)
		oppened_inventory_displayer = null
		InventorySystem.uncheck_last_focused_cell()
		InventorySystem.hide_description()

func open_continer(displayer : Inventory_Displayer):
	if displayer.get_parent() == null:
		player_inventory_displayer.get_parent().remove_child(player_inventory_displayer)
		displayer_grid.add_child(player_inventory_displayer)
		player_inventory_displayer.visible = true
		player_inventory_displayer.update_all_item_grid_cells()
		displayer_grid.add_child(displayer)
		visible = true
		check_all_displayers_if_mouse_inside()
		oppened_inventory_displayer = displayer
		
func check_all_displayers_if_mouse_inside():
	for displayer in displayer_grid.get_children():
		displayer.check_if_mouse_inside()

