extends Node

## Dialogue Template
# Visual script data is fed to a single dictionary based on the the template structure
# Code used and adapted from github.com/Tomek/Shingeki-no-Danjon
var dialogue : Dictionary
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

## Signal Handle
# Button control for demonstration purposes
func _on_Load_pressed():
	get_parent()._ready()
	$"../Panel"._get_dialogue(dialogue)

func _on_Choices_btn_pressed():
	get_parent().set_script(load("res://Dialogues/Choices_test.vs"))

func _on_Conclusion_btn_pressed():
	get_parent().set_script(load("res://Dialogues/Conclusion_test.vs"))

func _on_Conditions_btn_pressed():
	get_parent().set_script(load("res://Dialogues/Condition_test.vs"))
