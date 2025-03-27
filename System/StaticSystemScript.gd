extends Node

var player : Player
var map : Node2D


var player_position = null
var ground_items = null

func summon_ground_items(_ground_items:Dictionary):
	ground_items = _ground_items
	if map != null:
		for i in range(0,ground_items.size(),1):
			InventoryManager.spawn_item(
			Items.get_item_by_id(ground_items[str(i)].itemID),
			ground_items[str(i)].amount,
			Vector2(ground_items[str(i)].position_x,ground_items[str(i)].position_y),
			true
			)
		ground_items = null


func set_map(_map:Node2D):
	map = _map
	if ground_items != null:
		summon_ground_items(ground_items)


func change_player_position(where:Vector2):
	if player != null:
		player.position = where
	else:
		player_position = where


func set_player(_player:CharacterBody2D):
	player = _player
	if player_position != null:
		player.position = player_position
		player_position = null


func _input(event):
	if event.is_action("Stop_key"):
		if player != null:
			SaveSystem.save_game()
			get_tree().quit()
