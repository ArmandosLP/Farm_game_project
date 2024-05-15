extends StaticBody2D
class_name Chest_Structure
const inventory_displayer_preload = preload("res://Inventory_System/Scenes/Inventory_displayer.tscn")

@export var inventory : Inventory
var inventory_displayer : Inventory_Displayer

func _ready():
	inventory = Inventory.new()
	inventory_displayer = inventory_displayer_preload.instantiate()
	inventory_displayer.inventory = inventory

func get_inventory():
	return inventory

"""
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		InventorySystem.add_inventory(inventory)
"""

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		InventorySystem.remove_inventory(inventory)

