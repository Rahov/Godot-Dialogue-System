extends Node

onready var Convo = $"../Panel/Convo"
onready var Narr = $"../Panel/Narr"
onready var Name = $"../Panel/Name"

onready var C1 = $"../Panel/C1"
onready var C2 = $"../Panel/C2"
onready var C3 = $"../Panel/C3"
onready var _buttons = [C1, C2, C3]

onready var dialogueMaster = $"../../DialogueTest"

var dialogue = {}
var branch = 0

var step : String
var step_number : int = 0

func _on_Panel_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		step = step + (str(step_number + 1))
		_dialogue_system(step)

func _on_C1_pressed():
	_dialogue_system(C1.text)
	step = C1.text

func _on_C2_pressed():
	_dialogue_system(C2.text)
	step = C2.text


func _dialogue_system(_node_name : String):
	Name.text = dialogue[_node_name].NAME
	Narr.text = dialogue[_node_name].NARR
	Convo.text = dialogue[_node_name].CONVO

	if dialogue[_node_name].has("CHOICE"):
		for i in dialogue[_node_name].CHOICE.size():
			_buttons[i].text = dialogue[_node_name].CHOICE[i]
			_buttons[i].show()
	else:
		C1.hide()
		C2.hide()
		C3.hide()
	return _node_name

func _on_Button_pressed():
	branch = 0
	
	dialogueMaster.set_script(load("res://Dialogues/1Node.vs"))
	dialogueMaster._ready()
	
	step = _dialogue_system("init")
#	print("\n",dialogue["init_1"])
#	for i in dialogue.size():
#		print(i , "\n", dialogue[i])
#

func conversation(_id, _name, _icon, _narration, _dialogue):
	dialogue[_id] = {NAME = _name, ICON = _icon, NARR = _narration, CONVO = _dialogue}
	pass

func show_choice(_id, _name, _icon, _narration, _dialogue, _choice1, _choice2, _choice3):
	var _choices = []
	if _choice1 != "Null": _choices.append(tr(_choice1))
	if _choice2 != "Null": _choices.append(tr(_choice2))
	if _choice3 != "Null": _choices.append(tr(_choice3))
	#if _choice4 != "Null": _choices.append(tr(_choice4))
	
#	branch_stack.append(branch)
	dialogue[_id] = {NAME = _name, ICON = _icon, NARR = _narration, CONVO = _dialogue, CHOICE = _choices}
	pass
