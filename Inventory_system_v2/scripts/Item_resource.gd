extends Resource
class_name Item

@export var id : int

@export_group("Item propieties")
@export var name : String
@export_multiline var description : String
@export var max_stack : int = 64
@export var texture : Texture
@export var price : int = 0

@export_group("Seed propieties")
@export var can_be_planted : bool = false
@export var plant_resource : Plant

@export_group("Tool propieties")
@export var can_be_used_as_tool : bool = false
@export var tool_resource : Tool
