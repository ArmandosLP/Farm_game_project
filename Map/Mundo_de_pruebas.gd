extends TileMap

@onready var ground_item_list = %Ground_item_list

func _ready():
	StaticSystemScript.set_map(self)
	
