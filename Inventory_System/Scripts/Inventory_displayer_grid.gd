extends Control
class_name Inventory_displayer_grid

const inventory_displayer_preload = preload("res://Inventory_System/Scenes/Inventory_displayer.tscn")

@onready var grid_container = %GridContainer

func open(chests : Array[Chest_Structure]):
	remove_displayers()
	for chest in chests:
		if chest.inventory_displayer.get_parent() == null:
			grid_container.add_child(chest.inventory_displayer)

func remove_displayers():
	for displayer in grid_container.get_children():
		if displayer != InventorySystem.player_inventory_displayer:
			grid_container.remove_child(displayer)

func remove_displayer(displayer : Inventory_Displayer):
	if displayer.get_parent() != null:
		grid_container.remove_child(displayer)
		check_all_displayers_if_mouse_inside()
		InventorySystem.hide_description()

func add_displayer(displayer : Inventory_Displayer):
	if displayer.get_parent() == null:
		grid_container.add_child(displayer)
		check_all_displayers_if_mouse_inside()
		InventorySystem.hide_description()

func check_all_displayers_if_mouse_inside():
	for other_displayer in grid_container.get_children():
		other_displayer.check_if_mouse_inside()
