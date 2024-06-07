extends Node

#La herramienta que se encuentra en uso en el momento
var item : Item


func start_tool_action(_item : Item):
	item = _item
	if item.tool_resource.type == item.tool_resource.TOOL_TYPE.PICKAXE:
		StaticSystemScript.player.animate_tool_action()


func end_tool_action(tool_interactive_entitie : Node2D):
	tool_interactive_entitie.get_meta("ToolInteractionComponent").tool_interaction(item.tool_resource)
