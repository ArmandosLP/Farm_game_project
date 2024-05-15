extends Control
class_name Inventory_continer

@onready var grid_container = %GridContainer

func add_inventory_displayer(displayer : Inventory_Displayer):
	grid_container.add_child(displayer)

func remove_inventory_displayer(displayer : Inventory_Displayer):
	grid_container.remove_child(displayer)

func get_inventory_displayer_list():
	return grid_container.get_children()
