extends Control

#Conversacion placeholder. No sirve de mucho, mas que ocupar el puesto de la conversacion actual hasta ser remplazado
@export var conversation : ConversationText

#Preloads de la interzaces usadas para mostrar al jugador. Se guardan en constantes por lo que no pueden ser remplazados
const conversation_displayer_preload = preload("res://Conversation_system/Scenes/Conversation_displayer.tscn")
const button_displayer_preload = preload("res://Conversation_system/Scenes/Conversation_button.tscn")

#Animation player que sirve para mostrar el texto de forma sueva
#La unicas animaciones que tiene son "Show text" que hace que el texto se muestre poco a poco
#Y reset, que debe ser ejecutado para evitar solapamientos entre "Show text"
var animation_player : AnimationPlayer

#El texto que se muestra al jugador se guarda aqui, animation player se encargade mostrarlo poco a poco, con la animacion "Show text"
var text_displayer : RichTextLabel

#La unica instancia de conversation display, si el jugador no se encuentra en una conversacion, esta se vuelve invisible. Pero nunca se borra
var conversation_displayer : Conversation_Displayer

#Variable que cuenta la fase de la conversacion actual.
var text_iterator = 0

#Metodo ready, se carga nada mas se encienda el juego debido a que el script esta en los autoloads del proyecto
func _ready():
	#Se instancia por primera y ultima vez el display de conversaciones
	conversation_displayer = conversation_displayer_preload.instantiate()
	#Se agrega como hijo de este mismo nodo, que al ser un autoload, este siempre se encuentra cargado
	add_child(conversation_displayer)
	#Se vuelve invisible
	conversation_displayer.visible = false
	#El animation player se encuentra dentro del display, asi que se crea un acceso directo aqui
	animation_player = conversation_displayer.animation_player
	#El nodo del texto tambien se encuentra dentro del display, se crea otro acceso directo
	text_displayer = conversation_displayer.text_displayer


#Sirve para saltar la animacion de mostrar el texto.
#En caso de que la animacion ya haya terminado, se ejecuta el metodo next()
#METODO PARA DISEÑADORES
func skip() -> void:
	if conversation != null:
		if animation_player.get_current_animation() == "Show_text" and text_displayer.text.length() > conversation_displayer.visible_characters:
			conversation_displayer.visible_characters = 500
			animation_player.play("RESET")
		else:
			next()

#Metodo principal del sistema de conversaciones.
#Recibe un objeto de todo ConversationText y lo interpreta para empezar una conversacion
#METODO PARA DISEÑADORES
func start(_conversation : ConversationText) -> void:
	conversation_displayer.advertise_when_finished_displaying_text = false
	remove_question_buttons()
	animation_player.play("RESET")
	if _conversation != null:
		text_iterator = 0
		text_displayer.visible_characters = 0
		conversation = _conversation
		conversation_displayer.face_image.texture = conversation.face_image
		conversation_displayer.visible = true
		next()
	else:
		print("ERROR:")
		print("El sistema de conversaciones ha recibido un objeto nulo")

#Quita todos los nodos de tipo boton de la conversacion actual
#NO DEBE SER UTILIZADO POR EL DISEÑADOR
func remove_question_buttons() -> void:
	for button in conversation_displayer.button_list.get_children():
		conversation_displayer.button_list.remove_child(button)
		button.queue_free() 
		
#Termina una conversacion de forma abrupta.
#Su uso esta automatizado con las demas metodos.
#NO DEBE SER UTILIZADO POR EL DISEÑADOR AMENOS QUE SEA ESTRICTAMENTE NECESARIO
func end() -> void:
	conversation = null
	text_displayer.visible_characters = 0
	conversation_displayer.visible = false
	remove_question_buttons()

#Sirve para saltar de la fase de la conversacion actual a la siguiente
#Este metodo ignora si el texto se ha mostrado por completo o no
#Cuando una conversacion llega a su fase final:
#En caso de que el objeto ConversationText tenga alojada un objeto ConversationOption,
#ejecutara el metodo show_questions()
#En caso contrario ejecuta el metodo end()
#NO DEBE SER UTILIZADO POR EL DISEÑADOR AMENOS QUE SEA ESTRICTAMENTE NECESARIO
func next() -> void:
	if conversation == null:
		end()
		return
		
	if conversation.text.size() > text_iterator:
		text_displayer.text = conversation.text[text_iterator]
		conversation_displayer.visible_characters = 0
		if conversation.skip_animation:
			conversation_displayer.visible_characters = 500
		else:
			animation_player.play("RESET")
			animation_player.play("Show_text")
		text_iterator += 1
		if conversation.text.size() == text_iterator:
			if conversation.conversation_options != null:
				var conversation_options = conversation.conversation_options
				if conversation_options.show_responses_at_the_end_of_text == false:
					show_optionss()
				else:
					conversation_displayer.advertise_when_finished_displaying_text = true
	elif conversation.conversation_options != null:
		if conversation.conversation_options.can_be_skiped == true:
			var option : Option = conversation.conversation_options.options[conversation.conversation_options.response_on_skipping]
			end()
			option_was_chosen(option)
	else:
		end()


#Crea y muestra los botones con las respectivos datos del objeto QuestionOption que tenga el ConversationText actual
#NO DEBE SER UTILIZADO POR EL DISEÑADOR
func show_optionss():
	var conversation_options : ConversationOptions = conversation.conversation_options
	for i in range(0,conversation_options.options.size(),1):
		var button : Conversation_button = button_displayer_preload.instantiate()
		button.option = conversation_options.options[i]
		conversation_displayer.button_list.add_child(button)
		
func option_was_chosen(option : Option):
	if option.conversation != null:
		start(option.conversation)
	else:
		end()

func finished_displaying_text():
	if conversation != null and conversation.conversation_options != null:
		show_optionss()
	pass
