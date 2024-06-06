extends StaticBody2D
class_name Chest_Structure


@onready var animation_player = %AnimationPlayer
@onready var chest_sprite_1 = %ChestSprite1
@onready var chest_sprite_2 = %ChestSprite2
@onready var player_detector = %PlayerInteractionDetectorComponent


var inventory : Inventory
var oppened : bool = false


func _ready():
	inventory = Inventory.new()


func mouse_right_click():
	if player_detector.player_inside and !InventoryManager.get_visibility():
		StaticSystemScript.player.can_move(false)
		if !oppened:
			InventoryManager.allow_inventory_interaction = false
			animation_player.play("open")
		else:
			InventoryManager.open_continer(inventory)
		oppened = true


func chest_opening_animation_ended():
	InventoryManager.open_continer(inventory)
	InventoryManager.allow_inventory_interaction = true


func player_exited_area():
	chest_sprite_1.visible = true
	chest_sprite_2.visible = false
	if oppened:
		oppened = false
		animation_player.play("close")


func player_entered_area():
	chest_sprite_1.visible = false
	chest_sprite_2.visible = true
