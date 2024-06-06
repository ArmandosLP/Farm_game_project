extends Node

func use_tool(item : Item):
	var tool = item.tool_resource
	if tool.type == tool.TOOL_TYPE.PICKAXE:
		StaticSystemScript.player.animate_tool_action()
