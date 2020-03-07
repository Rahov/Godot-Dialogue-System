extends Node


var dialogue : Dictionary
var conversations : Dictionary
func _ready():
	var dir = Directory.new()
	if dir.open("res://Dialogues") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				print("Found file: " + file_name)
				conversations[file_name] = []
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func conversation(_id, _name, _icon, _narration, _dialogue):
	dialogue[_id] = {NAME = _name, ICON = _icon, NARR = _narration, CONVO = _dialogue}

func show_choice(_id, _name, _icon, _narration, _dialogue, _choice1, _choice2, _choice3, _choice4):
	var _choices = []
	if _choice1 != "Null": _choices.append(tr(_choice1))
	if _choice2 != "Null": _choices.append(tr(_choice2))
	if _choice3 != "Null": _choices.append(tr(_choice3))
	if _choice4 != "Null": _choices.append(tr(_choice4))
	
	dialogue[_id] = {NAME = _name, ICON = _icon, NARR = _narration, CONVO = _dialogue, CHOICE = _choices}

func return_to_conc(_id, _destination):
	dialogue[_id] = {DEST = _destination}

func _on_Button_pressed():
	get_parent()._ready()
	$"../Panel"._get_dialogue(dialogue)

func _on_Button2_pressed():
	get_parent().set_script(load("res://Dialogues/1Node.vs"))

func _on_Button3_pressed():
	get_parent().set_script(load("res://Dialogues/3Node.vs"))
