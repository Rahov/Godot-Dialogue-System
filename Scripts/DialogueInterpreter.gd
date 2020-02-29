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
	if ERROR_index(_node_ID):
		return ERR_DOES_NOT_EXIST
	elif dialogue[_node_ID].has("DEST"):
		_node_ID = dialogue[_node_ID].DEST
		
	var _buttons = [C1, C2, C3, C4]
	$"Name".text = dialogue[_node_ID].NAME
	$"Narr".text = dialogue[_node_ID].NARR
	$"Convo".text = dialogue[_node_ID].CONVO

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

func ERROR_index(_sample):
	var check_list = []
	for i in dialogue.keys():
		check_list.append(i)
	if !check_list.has(_sample):
		print("Index value: *", _sample, "* is not resolvable")
		return true
	return false
