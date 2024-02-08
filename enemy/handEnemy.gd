extends Node2D


@export var player := Node2D
#@export var varLevel := Node2D
@onready var varLevel = $".."

@onready var card1 = $CardEnemy
@onready var card2 = $CardEnemy2
@onready var card3 = $CardEnemy3
@onready var card4 = $CardEnemy4

@onready var progressBar = $ProgressBar

var timeAttackFloat = 0.0

var hpEnemy = 100
var damage = 8
var x = false
var SuccessProtectXDamage = false
var damageOnPlayer = 0
var cardsAmount = 0
var successProtectInt = 3
var cardsMaxAmount = 3

func _ready():
	card1.varLevel = varLevel
	card2.varLevel = varLevel
	card3.varLevel = varLevel
	card4.varLevel = varLevel
	restartHand(cardsAmount)
	Event.connect("Step", EndStep)
	
func _process(delta):
	progressBar.value = hpEnemy
	if Input.is_action_just_pressed("Space"):
		EndStep()


#Конец хода
func EndStep():
	Event.timeEnemy = true
	for i in 4:                             #атака всеми картами
		checkPlayerCard(i)
		x = false
		SuccessProtectXDamage = false
		await get_tree().create_timer(timeAttackFloat).timeout
		timeAttackFloat = 0
	Event.timeEnemy = false
	restartHand(cardsAmount)

#Перераздаем все карты
func restartHand(amount):
	var arr = [card1, card2, card3, card4]
	if cardsAmount < cardsMaxAmount:
		cardsAmount += 1
	for y in 4: 
		arr[y].numText(0)
		arr[y].destroyCard = false
	if amount == 3:
		amount = randi_range(2, 3)
	if amount == 4:
		amount = randi_range(3, 4)
	for i in amount:
		var rand = randi_range(0, arr.size()- 1)
		arr[rand].numText(randi_range(1, 4))
		arr.remove_at(rand)


#Проверка, есть ли защита от атаки
func checkPlayerCard(numb):
	var arrCards = [card1, card2, card3, card4]
	
	if arrCards[numb].numSymbol != 0:
		arrCards[numb].modulate = Color("eed300")
		timeAttackFloat = 0.5
		await get_tree().create_timer(0.3).timeout
		#arrCards[numb].modulate = Color("ffffff")
		
		for i in 4:
			if player.cards[numb].ArrSymbols[i] == arrCards[numb].numSymbol:
				SuccessProtect(numb, player.cards[numb].ArrSymbols[i])
		if !x:
			attackOnThePlayer(1)

#Удачная защита игрока
func SuccessProtect(n, damageColor):
	var audioProtect = $AudioProtect
	audioProtect.play()
	x = true
	varLevel.hpPlus1(successProtectInt)
	if player.StorageHand.cards[n].FindCard(damageColor) and !SuccessProtectXDamage:
		SuccessProtectXDamage = true
		await get_tree().create_timer(0.35).timeout
		player.StorageHand.cards[n].DamageX += 1
		var audioPowerUpCard = $AudioPowerUpCard
		audioPowerUpCard.play()
		


func cameraMovingDamageOnEnemy(n): #Для карт противника
	$"../Camera2D".shake(n)

#Атака по игроку
func attackOnThePlayer(damageLocal):
	var audioAttack = $AudioAttack
	audioAttack.play()
	$"../Camera2D".shake(0.3)
	var x = -damageLocal * damage
	varLevel.hpPlus1(x)
	damageOnPlayer = 0
