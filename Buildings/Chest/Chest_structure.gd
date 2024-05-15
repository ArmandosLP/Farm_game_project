extends StaticBody2D
class_name Chest_Structure

@export var inventory : Inventory

var displayer : Inventory_Displayer

func _ready():
	inventory = Inventory.new()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		displayer = InventorySystem.add_inventory(inventory)
		
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		InventorySystem.remove_inventory(inventory)
		if displayer != null:
			InventorySystem.remove_displayer(displayer)
			
