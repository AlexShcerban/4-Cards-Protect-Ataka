extends Node2D


var levelNumber

@export var damagePlayer = 8
@export var hpPlayer = 100
@export var hpRecovery = 4

@export var cardsAmount = 3
@export var damageEnemy = 8
@export var hpEnemy = 300

@onready var level = $Level
@onready var UIScene = $UiScene
@onready var enemy = get_node("Level/HandEnemy")
@onready var enemyBar = get_node("Level/HandEnemy/ProgressBar")
@onready var playerBar = get_node("Level/ProgressBar")



func _ready():
	levelNumber = Event.level
	SelectLevel(levelNumber)
	readyVariable()
	var labText = $Label
	labText.text = str(levelNumber)
	


func _process(delta):
	if level.hp < 0:
		UIScene.EndGameSession(false)
	if enemy.hpEnemy < 0:
		UIScene.EndGameSession(true)

func SelectLevel(n):
	if n == 1:
		cardsAmount = 1
		damageEnemy = 8
		hpEnemy = 50
	elif n == 2:
		cardsAmount = 2
		damageEnemy = 8
		hpEnemy = 100
	elif n == 3:
		cardsAmount = 3
		damageEnemy = 8
		hpEnemy = 180
	elif n == 4:
		cardsAmount = 3
		damageEnemy = 8
		hpEnemy = 300

#Объявление всех переменных
func readyVariable():
	level.hp = hpPlayer
	level.damage = damagePlayer
	enemy.hpEnemy = hpEnemy
	enemy.damage = damageEnemy
	enemy.successProtectInt = hpRecovery
	enemyBar.max_value = hpEnemy
	playerBar.max_value = hpPlayer
	enemy.cardsMaxAmount = cardsAmount

#Уровни сложности
"""func levelNormal():
	damagePlayer = 8
	hpPlayer = 100
	hpRecovery = 2

	cardsAmount = 3
	damageEnemy = 8
	hpEnemy = 100
	readyVariable()"""

