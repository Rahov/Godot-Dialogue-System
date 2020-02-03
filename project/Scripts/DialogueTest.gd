extends Node

onready var Convo = $"../Panel/Convo"
onready var Narr = $"../Panel/Narr"
onready var Name = $"../Panel/Name"

onready var C1 = $"../Panel/C1"
onready var C2 = $"../Panel/C2"
onready var C3 = $"../Panel/C3"
onready var _buttons = [C1, C2, C3]

onready var dialogueMaster = $"../../DialogueTest"

var dialogue = []
var step : int
var branch = 0


func _dialogue_system(_branch : int):
	Name.text = dialogue[_branch][step].NAME
	Narr.text = dialogue[_branch][step].NARR
	Convo.text = dialogue[_branch][step].CONVO
	
	if dialogue[_branch][step].has("CHOICE"):
		for i in dialogue[_branch][step].CHOICE.size():
			_buttons[i].text = dialogue[_branch][step].CHOICE[i]
			_buttons[i].show()
	else:
		C1.hide()
		C2.hide()
		C3.hide()
	

func _on_Button_pressed():
	branch = 0
	dialogue.append([])
	dialogueMaster.set_script(load("res://Dialogues/Node.vs"))
	dialogueMaster._ready()
	
	for i in dialogue.size():
		print(i , "\n", dialogue[i])
	print("all-size: ", dialogue.size())
#
	
#	print("\n", dialogue[0][1])
#	print("\n", dialogue[1][0])
#	print("\n", dialogue[2][0])
#	step = 0
#	_dialogue_system(0)

func _on_Panel_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		step += 1
		_dialogue_system(0)
	pass # Replace with function body.

func _on_C1_pressed():
	step = 0
	_dialogue_system(1)

func _on_C2_pressed():
	step = 0
	_dialogue_system(2)

func conversation(_name, _icon, _narration, _dialogue):
	dialogue[branch].append({NAME = tr(_name), ICON = _icon, NARR = tr(_narration), CONVO = tr(_dialogue)})

func show_choice(_name, _icon, _narration, _dialogue, _choice1, _choice2, _choice3):
	var _choices = []
	if _choice1 != "Null": _choices.append(tr(_choice1))
	if _choice2 != "Null": _choices.append(tr(_choice2))
	if _choice3 != "Null": _choices.append(tr(_choice3))
	#if _choice4 != "Null": _choices.append(tr(_choice4))
	
#	for i in range(_choices.size()):
#		dialogue[0].branches.append(dialogue.size())
#		dialogue.append({root = branch, messages = []})

#	branch_stack.append(branch)
#	dialogue[0].counter = _choices.size()
	dialogue[branch].append({NAME = tr(_name), ICON = _icon, NARR = tr(_narration), CONVO = tr(_dialogue), CHOICE = _choices})
	

var going0 : int 
func choice(i):
#	print(branch)
	print(i)
	branch = branch + i
	dialogue.append([])
#	if i == 0:
#		going0 = going0 + 1
#		print(going0)