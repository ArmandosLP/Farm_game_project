extends Area2D


func get_tool_interactive_entities() -> Array[Node2D]:
	var body_list = get_overlapping_bodies()
	var tool_interactive_entities : Array[Node2D] = []
	for body in body_list:
		if body.has_meta("ToolInteractionComponent"):
			tool_interactive_entities.append(body)
	return tool_interactive_entities

func tool_action():
	var tool_interactive_entities = get_tool_interactive_entities()
	if tool_interactive_entities.size() > 0:
		ProfessionsManager.end_tool_action(tool_interactive_entities[0])
