extends Resource
class_name Tool

enum TOOL_TYPE {NONE, PICKAXE, AXE, SHOVEL, HOE}

@export var type : TOOL_TYPE
@export var tier : int = 1
@export var texture : Texture
