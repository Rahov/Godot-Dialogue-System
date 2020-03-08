extends Panel


onready var C1 : Button = $"VB/C/C1"
onready var C2 : Button = $"VB/C/C2"
onready var C3 : Button = $"VB/C/C3"
onready var C4 : Button = $"VB/C/C4"

var dialogue : Dictionary
var conversations : Dictionary
var step : String

## Dialogue Interpreter
# gets the dialogue produced from the dialogue compiler
func _get_dialogue(_block : Dictionary):
	dialogue = _block
	
	step = _dialogue_system("init")
	# print(JSON.print(dialogue,'\t')) # Useful for printing the dialogue structure

# loads the dialogue onto the scene
# checks if the dialogue index exists
# could be improved...
func _dialogue_system(_node_ID : String):
	if ERROR_index(dialogue, _node_ID):
		return ERR_DOES_NOT_EXIST
	elif dialogue[_node_ID].has("DEST"):
		_node_ID = dialogue[_node_ID].DEST
		
	$"VB/D/Name".text = dialogue[_node_ID].NAME
	$"VB/D/Narr".text = dialogue[_node_ID].NARR
	$"VB/D/Convo".text = dialogue[_node_ID].CONVO

	var _buttons = [C1, C2, C3, C4]
	if dialogue[_node_ID].has("CHOICE"):
		for i in dialogue[_node_ID].CHOICE.size():
			_buttons[i].text = dialogue[_node_ID].CHOICE[i]
			_buttons[i].show()
	else:
		for i in _buttons.size():
			_buttons[i].hide()
	return _node_ID

# steps through dialogues by adding +1 on the ID 
var step_number : int
func _on_Panel_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		step_number += 1
		_dialogue_system(step + str(step_number))

# confirms the dialogue has the index requested
func ERROR_index(_struct : Dictionary, _sample : String) -> bool:
	if !_struct.keys().has(_sample):
		print("Index value: *", _sample, "* is not resolvable")
		return true
	return false

## Dialogue Database
# Used for gethering all Dialogues in a single Dictionary before the game has loaded
# initially left empty and later filled with player choices
# Code used and adapted from docs.godotengine.org
var convo_db : Dictionary
func _ready():
	var dir = Directory.new()
	if dir.open("res://Dialogues") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				print("Found file: " + file_name)
				convo_db[file_name] = []
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func dialogue_database(_script : String, _choice_entry : String):
	if convo_db[_script].has(_choice_entry):
		return 0
	var _choices : Array
	_choices = convo_db[_script]
	_choices.append(_choice_entry)
	convo_db[_script] = _choices
	print(JSON.print(convo_db,'\t'))


## Signal Handle 
# Button control for dialogue navigation
# Uses the contents within the button to navigate to the next ID
func _on_C1_pressed():
	button_pressed(C1.text)
func _on_C2_pressed():
	button_pressed(C2.text)
func _on_C3_pressed():
	button_pressed(C3.text)
func _on_C4_pressed():
	button_pressed(C4.text)

func button_pressed(_text : String):
	dialogue_database(get_parent().get_script().get_path().get_file(), _text)
	_dialogue_system(_text)
	step = _text
	step_number = 0
