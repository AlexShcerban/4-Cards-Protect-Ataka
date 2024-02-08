extends Node2D

@export var card := Node2D
@export var varLevel := Node2D
@export var nonSave = false

func _ready():
	card.varLevel = varLevel
	newCard()
	Event.connect("Step", newCardTimer)



func _process(delta):
	if Input.is_action_just_pressed("Space"):
		newCard()

func newCardTimer():
	await get_tree().create_timer(0.4).timeout
	newCard()

func newCard():
	var procent = randi_range(1, 100)
	var x = 0
	if procent < 20:
		x = 3
	elif procent < 60:
		x = 2
	else:
		x = 1
	if card.ArrSymbols == [0, 0, 0, 0] or nonSave:
		card.ArrSymbols == [0, 0, 0, 0]
		card.modulate.a = 2
		for i in x:
			card.ArrSymbols[i] = randi_range(1, 4)
	$card.printText()
