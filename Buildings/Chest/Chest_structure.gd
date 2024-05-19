extends StaticBody2D
class_name Chest_Structure
const inventory_displayer_preload = preload("res://Inventory_System/Scenes/Inventory_displayer.tscn")

@onready var animation_player = %AnimationPlayer
@onready var chest_sprite_1 = %ChestSprite1
@onready var chest_sprite_2 = %ChestSprite2

var inventory : Inventory
var inventory_displayer : Inventory_Displayer
var oppened : bool = false

func _ready():
	inventory = Inventory.new()
	inventory_displayer = inventory_displayer_preload.instantiate()
	inventory_displayer.inventory = inventory

@onready var player_detector = %PlayerInteractionDetectorComponent
func mouse_left_click():
	if player_detector.player_inside and !InventorySystem.continer_oppened and !InventorySystem.inventory_oppened and InventorySystem.continer_interaction:
		InventorySystem.allow_continer_interaction(false)
		InventorySystem.allow_player_inventory_interaction(false)
		StaticSystemScript.player.can_move(false)
		if !oppened:
			animation_player.play("open")
		else:
			InventorySystem.open_continer(inventory_displayer)
		oppened = true

func chest_opening_animation_ended():
	InventorySystem.open_continer(inventory_displayer)

func player_exited_area():
	chest_sprite_1.visible = true
	chest_sprite_2.visible = false
	if oppened:
		oppened = false
		animation_player.play("close")

func player_entered_area():
	chest_sprite_1.visible = false
	chest_sprite_2.visible = true
