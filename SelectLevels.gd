extends Node2D



@onready var buttons = $Panel/ScrollContainer/HBoxContainer
var valueButtons = [1, 2, 3, 0]

func _ready():
	for i in 4:
		buttons.get_child(i+1).get_child(0).pressed.connect(self.OpenLevel.bind(valueButtons[i]))


func OpenLevel(nomer):
	Event.level = nomer
	get_tree().change_scene_to_file("res://LevelParts/mainLevel.tscn")
