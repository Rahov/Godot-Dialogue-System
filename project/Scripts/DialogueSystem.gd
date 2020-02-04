extends Node

onready var ui = get_parent()

var dialogue = []
var branch_stack = []
var branch = 0

func _ready():
	get_parent().connect("choice_selected", self, "set_choice")

func _on_Button_pressed():
	dialogue()

func dialogue():
	dialogue = [{root = -1, messages = [], branches = []}]
	branch_stack = []
	branch = 0
	
	var _dialogue = $"../../DialogueTest"
	_dialogue.set_script(load("res://Dialogues/Uganda2.vs"))
	_dialogue._ready()
	
	print(dialogue)
#	_dialogue.queue_free()
#	get_parent().start_dialogue(dialogue)

func show_message(_name, _narration):
	dialogue[branch].messages.append({speaker = name, message = _narration})

func show_choice(name, _narration, choice1, choice2, choice3):
	var _choices = []
	if choice1 != "Null": _choices.append(choice1)
	if choice2 != "Null": _choices.append(choice2)
	if choice3 != "Null": _choices.append(choice3)
#	if choice4 != "Null": _choices.append(choice4)
	
	for i in range(_choices.size()):
		print(dialogue)
		dialogue[branch].branches.append(dialogue.size())
		dialogue.append({root = branch, messages = []})
	
	branch_stack.append(branch)
	dialogue[branch].counter = _choices.size()
	dialogue[branch].messages.append({speaker = name, message = _narration, choices = _choices})

func on_choice(i):
	branch = dialogue[branch_stack.back()].branches[i]
	dialogue[branch_stack.back()].counter -= 1
	if dialogue[branch_stack.back()].counter == 0:
		branch_stack.pop_back()