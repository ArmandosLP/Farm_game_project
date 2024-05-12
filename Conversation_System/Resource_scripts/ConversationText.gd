extends Resource
class_name ConversationText

func _init(_skip_animation : bool, _text : String, _next : int):
	skip_animation = _skip_animation
	text = _text
	next = _next

var face_image : Texture
var skip_animation : bool
var text : String
var next : int
