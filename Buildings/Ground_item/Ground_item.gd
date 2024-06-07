extends Node2D
class_name Ground_item

@export var item:Item
@export var amount:int = 1
@onready var detector = %PlayerInteractionDetectorComponent
@onready var timer = %Timer
@onready var item_sprite = %Item_sprite
var timer_is_out:bool = false


func _ready():
	item_sprite.texture = item.texture
	timer.start()


func _process(delta):
	if timer_is_out:
		if detector.player_inside:
			if InventoryManager.ply_inventory.has_free_space() or InventoryManager.ply_inventory.can_stack(item):
				position += (StaticSystemScript.player.position - position).normalized() * delta * 150
				if position.distance_to(StaticSystemScript.player.position) < 4:
					var extra = InventoryManager.add_item(InventoryManager.ply_inventory,item,amount)
					amount -= amount - extra
					if amount == 0: queue_free()


func _on_timer_timeout():
	timer_is_out = true
