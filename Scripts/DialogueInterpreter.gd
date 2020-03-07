extends Panel


onready var C1 : Button = $"C1"
onready var C2 : Button = $"C2"
onready var C3 : Button = $"C3"
onready var C4 : Button = $"C4"

var dialogue : Dictionary
var step : String

func _get_dialogue( _block : Dictionary):
	dialogue = _block
	step = _dialogue_system("init")

func _dialogue_system(_node_ID : String):
	if ERROR_index(dialogue, _node_ID):
		return ERR_DOES_NOT_EXIST
	elif dialogue[_node_ID].has("DEST"):
		_node_ID = dialogue[_node_ID].DEST
		
	$"Name".text = dialogue[_node_ID].NAME
	$"Narr".text = dialogue[_node_ID].NARR
	$"Convo".text = dialogue[_node_ID].CONVO

	var _buttons = [C1, C2, C3, C4]
	if dialogue[_node_ID].has("CHOICE"):
		for i in dialogue[_node_ID].CHOICE.size():
			_buttons[i].text = dialogue[_node_ID].CHOICE[i]
			_buttons[i].show()
	else:
		for i in _buttons.size():
			_buttons[i].hide()
	return _node_ID


var step_number : int
func _on_Panel_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		step_number += 1
		_dialogue_system(step + str(step_number))
		pass

func _on_C1_pressed():
	button_pressed(C1.text)
func _on_C2_pressed():
	button_pressed(C2.text)
func _on_C3_pressed():
	button_pressed(C3.text)
func _on_C4_pressed():
	button_pressed(C4.text)

func button_pressed(_text : String):
	_dialogue_system(_text)
	step = _text
	step_number = 0

func ERROR_index(_struct : Dictionary, _sample : String):
	if !_struct.keys().has(_sample):
		print("Index value: *", _sample, "* is not resolvable")
		return true
	return false



#func dialogue_database(_script : String, _choice_entry : String):
#	if conversations[_script].has(_choice_entry):
#		return 0
#	var _choices : Array
#	_choices = conversations[_script]
#	_choices.append(_choice_entry)
#	conversations[_script] = _choices
#	print(JSON.print(conversations))

# this is how printing is done
# print(JSON.print(mainDict,'\t'))
