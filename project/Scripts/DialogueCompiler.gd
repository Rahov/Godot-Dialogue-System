extends Node


var dialogue : Dictionary = {}
func _on_Button_pressed():
	$"../../DialogueTest".set_script(load("res://Dialogues/1Node.vs"))
	$"../../DialogueTest"._ready()
	
	$"../Panel"._get_dialogue(dialogue)

func conversation(_id, _name, _icon, _narration, _dialogue):
	dialogue[_id] = {NAME = _name, ICON = _icon, NARR = _narration, CONVO = _dialogue}

func show_choice(_id, _name, _icon, _narration, _dialogue, _choice1, _choice2, _choice3):
	var _choices = []
	if _choice1 != "Null": _choices.append(tr(_choice1))
	if _choice2 != "Null": _choices.append(tr(_choice2))
	if _choice3 != "Null": _choices.append(tr(_choice3))
	#if _choice4 != "Null": _choices.append(tr(_choice4))
	
	dialogue[_id] = {NAME = _name, ICON = _icon, NARR = _narration, CONVO = _dialogue, CHOICE = _choices}