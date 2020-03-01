extends Node


var dialogue : Dictionary = {}
func conversation(_id, _name, _icon, _narration, _dialogue):
	dialogue[_id] = {NAME = _name, ICON = _icon, NARR = _narration, CONVO = _dialogue}

func show_choice(_id, _name, _icon, _narration, _dialogue, _choice1, _choice2, _choice3, _exit):
	var _choices = []
	if _choice1 != "Null": _choices.append(tr(_choice1))
	if _choice2 != "Null": _choices.append(tr(_choice2))
	if _choice3 != "Null": _choices.append(tr(_choice3))
	if _exit != "Null": _choices.append(tr(_exit))
	
	dialogue[_id] = {NAME = _name, ICON = _icon, NARR = _narration, CONVO = _dialogue, CHOICE = _choices}

func return_to_conc(_id, _destination):
	dialogue[_id] = {DEST = _destination}

func status(_script : String, _choice : String, _change : String):
	if $"../Panel".conversations[_script].has(_choice):
		return _change

func _on_Button_pressed():
	$"../../DialogueTest"._ready()
	$"../Panel"._get_dialogue(dialogue)

func _on_Button2_pressed():
	$"../../DialogueTest".set_script(load("res://Dialogues/1Node.vs"))

func _on_Button3_pressed():
	$"../../DialogueTest".set_script(load("res://Dialogues/3Node.vs"))
