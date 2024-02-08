extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	pass


#Основные функции
func EndGameSession(win):
	var winUI = $win
	var loserUI = $loser
	var pauseButton = $Pause1
	pauseButton.visible = false
	if win:
		winUI.visible = true
	else:
		loserUI.visible = true

func restart():
	get_tree().reload_current_scene()
	
func pause(pauseOn):
	var pauseObj = $pause
	var pauseButton = $Pause1
	if pauseOn:
		pauseObj.visible = true
		pauseButton.visible = false
	else:
		pauseObj.visible = false
		pauseButton.visible = true

func menu():
	get_tree().change_scene_to_file("res://SelectLevels.tscn")

func next():
	Event.level += 1
	restart()





#Кнопки
func _on_restart_pressed():
	restart()

func _on_menu_pressed():
	menu()

func _on_close_pressed():
	pause(false)

func _on_pause_button_pressed():
	pause(true)


func _on_close_2_pressed():
	pause(false)


func _on_next_pressed():
	next()
