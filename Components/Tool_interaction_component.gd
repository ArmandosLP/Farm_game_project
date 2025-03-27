extends Node
class_name ToolInteractionComponent


@export var required_tool_type : Tool.TOOL_TYPE = Tool.TOOL_TYPE.NONE
@export var required_tool : Tool
@export var required_tier : int = -1


func _on_tree_entered():
	owner.set_meta(&"ToolInteractionComponent",self)


func _on_tree_exited():
	if owner != null:
		owner.remove_meta(&"ToolInteractionComponent")


func tool_interaction(tool_resource : Tool):
	if owner.has_method("tool_action"):
		if required_tool == tool_resource:
			owner.tool_action(tool_resource)
		if required_tool_type == Tool.TOOL_TYPE.NONE or required_tool_type == tool_resource.type:
			if required_tier == -1 or tool_resource.tier >= required_tier:
				owner.tool_action(tool_resource)
