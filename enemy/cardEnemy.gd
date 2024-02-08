extends Node2D


var numSymbol = 0
var varLevel
var mouseEntered = false
var destroyCard = false

func _ready():
	pass


func _process(delta):
	#Атака по карте
	if (Input.is_action_just_released("Click") or Input.is_action_just_pressed("Click")) and mouseEntered and numSymbol != 0:
		if varLevel.cardInHand:
			for i in 3:
				if varLevel.cardSymbols[i] == numSymbol:
					deleteCard()
					damageOnEnemy(varLevel.damage * varLevel.DamageX)
					varLevel.cardSymbols[i] = 0
					varLevel.cardAttack = true
					#varLevel.cardInHand = false

#Вывод номера/символа
func numText(number):
	var objSymbols = get_node("CardTexture/Symbols/1")
	numSymbol = number
	for i in 4:
		objSymbols.get_child(i).hide()
	if numSymbol == 0:
		deleteCard()
	else:
		modulate.a = 2
		objSymbols.get_child(numSymbol - 1).show()


func damageOnEnemy(damage):
	if !destroyCard:
		get_parent().hpEnemy -= damage
		destroyCard = true
		$"..".cameraMovingDamageOnEnemy(0.05)
		$"../ProgressBar".modulate = Color("ff002f")
		await get_tree().create_timer(0.3).timeout
		$"../ProgressBar".modulate = Color("b7001f")

func deleteCard():
	if numSymbol != 0:
		var hit1Audio = $AudioStreamPlayer2D
		hit1Audio.play()
	modulate = Color("ffffff")
	modulate.a = 0.2
	numSymbol = 0

func _on_area_2d_mouse_entered():
	mouseEntered = true
func _on_area_2d_mouse_exited():
	mouseEntered = false

