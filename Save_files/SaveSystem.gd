extends Node


func save_game():
	save_inventory()
	save_player_stats()
	save_map()

func load_game():
	load_inventory()
	load_player_stats()
	load_map()


func load_map():
	var fileWirter := FileAccess.open("res://Save_files/ground_items.json",FileAccess.READ)
	var ground_items = JSON.parse_string(fileWirter.get_as_text())
	StaticSystemScript.summon_ground_items(ground_items)


func save_map():
	var fileWirter := FileAccess.open("res://Save_files/ground_items.json",FileAccess.WRITE)
	var ground_items:Array[Node] = StaticSystemScript.map.ground_item_list.get_children()
	
	var ground_item_dic : Dictionary = {}
	
	for i in range(0,ground_items.size(),1):
		ground_item_dic[i] = {
			position_x = ground_items[i].position.x,
			position_y = ground_items[i].position.y,
			itemID = ground_items[i].item.id,
			amount = ground_items[i].amount}
		
	fileWirter.store_line(JSON.stringify(ground_item_dic))
	fileWirter.close()


func save_player_stats():
	var fileWirter := FileAccess.open("res://Save_files/player_stats.json",FileAccess.WRITE)
	var pos_x:float = StaticSystemScript.player.position.x
	var pos_y:float = StaticSystemScript.player.position.y
	var money:int = EconomyManager.player_money
	
	var stats:Dictionary = {}
	
	stats.position_x = pos_x
	stats.position_y = pos_y
	stats.player_money = money
	
	fileWirter.store_line(JSON.stringify(stats))
	fileWirter.close()

func load_player_stats():
	var fileWirter := FileAccess.open("res://Save_files/player_stats.json",FileAccess.READ)
	var stats = JSON.parse_string(fileWirter.get_as_text())
	
	EconomyManager.initialize()
	EconomyManager.set_money(stats["player_money"])
	StaticSystemScript.change_player_position(Vector2(stats["position_x"],stats["position_y"]))
		
	
func save_inventory():
	var fileWirter := FileAccess.open("res://Save_files/player_inventory.json",FileAccess.WRITE)
	var ply_inventory = InventoryManager.ply_inventory
	
	var inventory:Dictionary = {}
	
	for i in range(0,ply_inventory.items.size(),1):
		if ply_inventory.items[i] != null:
			inventory[i] = {"itemID": ply_inventory.items[i].id, "amount":ply_inventory.amount[i]}
		else:
			inventory[i] = null
			
	fileWirter.store_line(JSON.stringify(inventory))
	fileWirter.close()


func load_inventory():
	var fileWirter := FileAccess.open("res://Save_files/player_inventory.json",FileAccess.READ)
	var items = JSON.parse_string(fileWirter.get_as_text())

	InventoryManager.initialize()
	var ply_inventory = InventoryManager.ply_inventory

	for i in range(0,items.size(),1):
		if items[str(i)] != null:
			InventoryManager.set_item(
				ply_inventory,
				i,
				Items.get_item_by_id(items[str(i)].itemID),
				items[str(i)].amount)
	fileWirter.close()
	
	
func read_config_file() -> Dictionary:
	var fileWirter := FileAccess.open("res://Save_files/config.json",FileAccess.READ)
	var config = JSON.parse_string(fileWirter.get_as_text())
	fileWirter.close()
	return config
	
func save_config_file(config : Dictionary) -> void:
	var fileWirter := FileAccess.open("res://Save_files/config.json",FileAccess.WRITE)
	fileWirter.store_line(JSON.stringify(config))
	fileWirter.close()
