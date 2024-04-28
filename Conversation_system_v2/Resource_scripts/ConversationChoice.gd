extends Resource
class_name ConversationChoice

func _init(_show_responses_at_the_end_of_text : bool, _response_on_skipping : int,_text : String):
	text = _text
	show_responses_at_the_end_of_text = _show_responses_at_the_end_of_text
	response_on_skipping = _response_on_skipping

var options : Array[Option]
var text : String
var response_on_skipping : int
var show_responses_at_the_end_of_text : bool

