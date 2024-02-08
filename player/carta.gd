extends Node2D

@export var ArrSymbols = [0, 0, 0, 0]
@onready var TextDamage = $Label
var mouseEntered = false
@export var varLevel := Node2D# = preload("res://level.gd")
@export var protectCard = false
var DamageX = 1
@export var cardDelete = false

@onready var audioSetCard = $AudioSetCard
@onready var audioGetCard = $AudioGetCard


func _ready():
	destroyCard()
	await get_tree().create_timer(0.1).timeout
	printText()
	#Event.connect("Step", printText)

func _process(delta):
	if DamageX > 1:
		TextDamage.text = "x" + str(DamageX)
	else:
		TextDamage.text = ""
	
	
	# перенос карты
	if (Input.is_action_just_released("Click") or Input.is_action_just_pressed("Click")) and mouseEntered:
		if varLevel.cardInHand:
			if cardDelete:
				varLevel.cardInHand = false
				$AudioDelete.play()
				return
			if ArrSymbols == [0, 0, 0, 0] or protectCard:
				if varLevel.cardAttack:              
					deleteAttackCard()
				else:
					setCard()
			elif ArrSymbols != [0, 0, 0, 0] and !protectCard:
				if varLevel.cardAttack:    
					deleteAttackCard()
				else:
					replaceTwoCard()
		else:
			if ArrSymbols != [0, 0, 0, 0] and !protectCard and !Event.timeEnemy:    
				getCard()
		printText()
	#if Input.is_action_just_pressed("Space"):
		#printText()


#Установка карты
func setCard():
	ArrSymbols = varLevel.cardSymbols     
	modulate = Color(1, 1, 1, 1)
	varLevel.cardInHand = false
	DamageX = varLevel.DamageX
	audioSetCard.play()
	if protectCard:
		var cardTexture = $CardTexture
		cardTexture.modulate = Color(0.6, 0.6, 0.85, 1)

#Взятие карты
func getCard():
	varLevel.cardSymbols = ArrSymbols
	varLevel.cardInHand = true
	varLevel.cardAttack = false
	varLevel.PlaceTakeCard = self
	varLevel.DamageX = DamageX
	audioGetCard.play()
	destroyCard()

#Уничтожение атакующей карты
func deleteAttackCard():
	varLevel.cardInHand = false
	varLevel.cardAttack = false

#Замена двух карт местами
func replaceTwoCard():
	var ArrSymbolsLocal = ArrSymbols     #Замена карты
	var DamageXLocal = DamageX
	ArrSymbols = varLevel.cardSymbols
	DamageX = varLevel.DamageX
	varLevel.cardInHand = false
	audioSetCard.play()
	varLevel.PlaceTakeCard.ArrSymbols = ArrSymbolsLocal
	varLevel.PlaceTakeCard.modulate.a = 2
	varLevel.PlaceTakeCard.printText()
	varLevel.PlaceTakeCard.DamageX = DamageXLocal


#Нужно для handEnemy
func FindCard(n):
	for i in 3:
		if ArrSymbols[i] == n and ArrSymbols[i] != 0:
			return true
	

func destroyCard():
	DamageX = 1
	ArrSymbols = [0, 0, 0, 0]
	modulate.a = 0.15


func printText():
	var x = ""
	var obj = get_node("CardTexture/Symbols")
	for i in 3:
		for y in 4:
			obj.get_child(i).get_child(y).hide()
		if ArrSymbols[i] == 1:
			obj.get_child(i).get_child(0).show()
		elif ArrSymbols[i] == 2:
			obj.get_child(i).get_child(1).show()
		elif ArrSymbols[i] == 3:
			obj.get_child(i).get_child(2).show()
		elif ArrSymbols[i] == 4:
			obj.get_child(i).get_child(3).show()
		#if ArrSymbols[i] != 0:
		#	x += str(ArrSymbols[i]) + " "
	#cards.text = x


func _on_area_2d_mouse_entered():
	mouseEntered = true
func _on_area_2d_mouse_exited():
	mouseEntered = false
