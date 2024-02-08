extends Node2D


@onready var card1 = $card
@onready var card2 = $card2
@onready var card3 = $card3
@onready var card4 = $card4
var cards    #Это нужно для  hand emeny 
@export var varLevel := Node2D
@export var StorageHand := Node2D
@export var protectVar = false

func _ready():
	cards = [card1, card2, card3, card4]
	card1.varLevel = varLevel
	card2.varLevel = varLevel
	card3.varLevel = varLevel
	card4.varLevel = varLevel
	if protectVar:
		card1.protectCard = true
		card2.protectCard = true
		card3.protectCard = true
		card4.protectCard = true



func _process(delta):
	pass
