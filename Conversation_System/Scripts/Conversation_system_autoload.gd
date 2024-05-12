extends Control

#Conversacion placeholder. No sirve de mucho, mas que ocupar el puesto de la conversacion actual hasta ser remplazado
var conversation

#Preloads de la interzaces usadas para mostrar al jugador. Se guardan en constantes por lo que no pueden ser remplazados
const conversation_displayer_preload = preload("res://Conversation_System/Scenes/Conversation_displayer.tscn")
const button_displayer_preload = preload("res://Conversation_System/Scenes/Conversation_button.tscn")

#Animation player que sirve para mostrar el texto de forma sueva
#La unicas animaciones que tiene son "Show text" que hace que el texto se muestre poco a poco
#Y reset, que debe ser ejecutado para evitar solapamientos entre "Show text"
var animation_player : AnimationPlayer

#El texto que se muestra al jugador se guarda aqui, animation player se encargade mostrarlo poco a poco, con la animacion "Show text"
var text_displayer : RichTextLabel

#La imagen que ve el jugador en la conversacion, puede estar en nulo
var face_image : TextureRect

#La unica instancia de conversation display, si el jugador no se encuentra en una conversacion, esta se vuelve invisible. Pero nunca se borra
var conversation_displayer : Conversation_Displayer

#Variable que cuenta la fase de la conversacion actual.
var iterator = 0

#El contenedor que contiene la imagen de la conversacion, se vuelve invisible cuando no tiene imagen
var contenedor_imagen : PanelContainer

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
	#El nodo donde se guarda la imagen que se muestra en la conversacion
	face_image = conversation_displayer.face_image
	#Contenedor que contiene la imagen de la conversacion
	contenedor_imagen = conversation_displayer.contenedor_imagen
	
#Termina una conversacion de forma abrupta.
#Su uso esta automatizado con las demas metodos.
#NO DEBE SER UTILIZADO POR EL DISEÑADOR AMENOS QUE SEA ESTRICTAMENTE NECESARIO
func end() -> void:
	in_question = false
	conversation.clear()
	conversation_displayer.visible = false
	remove_question_buttons()

#Metodo principal del sistema de conversaciones.
#Recibe un objeto de todo ConversationText y lo interpreta para empezar una conversacion
#METODO PARA DISEÑADORES
func start(_conversation) -> void:
	in_question = false
	remove_question_buttons()
	conversation_displayer.advertise_when_finished_displaying_text = false
	#remove_question_buttons()
	animation_player.play("RESET")
	iterator = 0
	text_displayer.visible_characters = 0
	conversation = _conversation
	#conversation_displayer.face_image.texture = conversation.face_image
	conversation_displayer.visible = true
	next()

#Lee un fichero y empieza la conversacion instantaneo
func read_and_start(path) -> void:
	start(read_file(path))

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

#Sirve para saltar de la fase de la conversacion actual a la siguiente
#Este metodo ignora si el texto se ha mostrado por completo o no
#Cuando una conversacion llega a su fase final:
#En caso de que el objeto ConversationText tenga alojada un objeto ConversationOption,
#ejecutara el metodo show_questions()
#En caso contrario ejecuta el metodo end()
#NO DEBE SER UTILIZADO POR EL DISEÑADOR AMENOS QUE SEA ESTRICTAMENTE NECESARIO
var in_question = false
func next() -> void:
	if conversation.size() > iterator and iterator != -1:
		if !in_question:
			text_displayer.text = conversation[iterator].Text
			show_text(conversation[iterator].Animation)
			if conversation[iterator].Image != null:
				contenedor_imagen.visible = true
				face_image.texture = face_gallery[conversation[iterator].Image]
			else:
				contenedor_imagen.visible = false
		if conversation[iterator].has("Options"):
			in_question = true
			if conversation[iterator].Show_at_end == true:
				conversation_displayer.advertise_when_finished_displaying_text = true
			else:
				show_optionss(conversation[iterator].Options)
			iterator = conversation[iterator].Next
		else:
			iterator = conversation[iterator].Next
	else:
		end()

#Metodo que es ejecutado por el displayer de la conversacion
#Cuando termina de mostrar todo el texto de la conversacion actual
#NO DEBE SER UTILIZADO POR EL DISEÑADOR
func finished_displaying_text():
	show_optionss(conversation[iterator].Options)

#Crea y muestra los botones con las respectivos datos del objeto QuestionOption que tenga el ConversationText actual
#NO DEBE SER UTILIZADO POR EL DISEÑADOR
func show_optionss(options):
	remove_question_buttons()
	for i in range(0,options.size(),1):
		var button : Conversation_button = button_displayer_preload.instantiate()
		button.option = options[i]
		conversation_displayer.button_list.add_child(button)

#Metodo que recibe el metodo que fue tomado por el jugador
#Y activa sus efectos.
#NO DEBE SER UTILIZADO POR EL DISEÑADOR AMENOS QUE SEA ESTRICTAMENTE NECESARIO
func option_was_chosen(option):
	in_question = false
	iterator = option.Next
	remove_question_buttons()
	next()

#Quita todos los nodos de tipo boton de la conversacion actual
#NO DEBE SER UTILIZADO POR EL DISEÑADOR
func remove_question_buttons() -> void:
	for button in conversation_displayer.button_list.get_children():
		conversation_displayer.button_list.remove_child(button)
		button.queue_free() 

#Metodo que muestra el texto al jugador, ya sea instantaneo o con animacion
#NO DEBE SER UTILIZADO POR EL DISEÑADOR
func show_text(animate : bool):
	animation_player.play("RESET")
	if animate == true:
		conversation_displayer.visible_characters = 0
		text_displayer.visible_characters = 0
		animation_player.play("Show_text")
	else:
		conversation_displayer.visible_characters = 500

#Metodo que recibe la ruta de un fichero de conversacion
#Devuelve un diccionario de dicha conversacion
#METODO PARA DISEÑADORES
func read_file(path : String):
	#Comprueba si el fichero en la ruta recibida existe.
	if !FileAccess.file_exists(path):
		#Si el fichero no existe, saca un error por la consola y devuelve null
		print("ERROR")
		print("No se ha encontrado el fichero " + path + ".")
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	var _conversation = JSON.parse_string(file.get_as_text())
	file.close()
	return _conversation

#Galeria de imagenes
var face_gallery = {
	"Debug": preload("res://Assets/placeholder.jpg"), #Cara debug para pruebas
	"Null": null
}
