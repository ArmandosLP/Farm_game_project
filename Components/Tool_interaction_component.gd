extends Node
class_name ToolInteractionComponent

func _on_tree_entered():
	owner.set_meta(&"ToolInteractionComponent",self)

func _on_tree_exited():
	owner.remove_meta(&"ToolInteractionComponent")

func tool_interaction(tool_resource : Tool):
	if owner.has_method("tool_interaction"):
		owner.tool_interaction(tool_resource)

