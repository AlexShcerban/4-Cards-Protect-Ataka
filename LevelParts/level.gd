extends Node2D


var hp = 100
var damage = 8
var cardSymbols = [3, 2, 1, 0]
var cardInHand = false
var cardAttack = false
var DamageX = 1
@onready var cardInHandObj = $CardTexture
@onready var progressBar = $ProgressBar
var PlaceTakeCard


func _ready():
	pass # Replace with function body.



func _process(delta):
	if cardSymbols == [0, 0, 0, 0]:
		cardInHand = false
	
	if hp > 100:
		hp = 100
	
	progressBar.value = hp
	
	# Передвижение карты за курсором
	if cardInHand:
		cardInHandObj.position = get_global_mouse_position()
		cardInHandObj.visible = true
		#cardInHandObj.get_child(0).text = str(cardSymbols)
		printText()
	else:
		cardInHandObj.visible = false

func printText():
	if cardAttack:
		cardInHandObj.modulate = Color(0.85, 0.6, 0.6, 1)
	else:
		cardInHandObj.modulate = Color(1, 1, 1, 1)
	var x = ""
	var obj = get_node("CardTexture/Symbols")
	for i in 3:
		for y in 4:
			obj.get_child(i).get_child(y).hide()
		if cardSymbols[i] == 1:
			obj.get_child(i).get_child(0).show()
		elif cardSymbols[i] == 2:
			obj.get_child(i).get_child(1).show()
		elif cardSymbols[i] == 3:
			obj.get_child(i).get_child(2).show()
		elif cardSymbols[i] == 4:
			obj.get_child(i).get_child(3).show()

func hpPlus1(hpLocal):
	hp += hpLocal
	progressBar.modulate = Color("ff002f")
	await get_tree().create_timer(0.3).timeout
	progressBar.modulate = Color("b7001f")

func _on_button_pressed():
	if !Event.timeEnemy:
		var audioStepButton = $AudioStepButton
		audioStepButton.play()
		Event.emit_signal("Step")
		cardInHand = false
	#Event.connect("Step", _go)
