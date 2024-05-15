extends StaticBody2D
class_name Chest_Structure

@export var inventory : Inventory

func _ready():
	inventory = Inventory.new()
	print(inventory.items)

var player_in_area : CharacterBody2D

func _input(event):
	if Input.is_action_just_pressed("ui_up") and player_in_area != null:
		InventorySystem.open_inventory_continer(inventory)
		
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_area = body

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_area = null
		InventorySystem.close_inventory_continer()
