extends Camera2D


var shakePower := 0.0
var shakeTime := 0.0 #В чем раззница между := и =  ???????
var shakeOne = 0.0
var shakeOffset := Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shakeTime < Time.get_ticks_msec():
		offset = lerp(offset, Vector2.ZERO, delta*10) #Плавно перемещаем камеру
		return
	
	if shakeOne < Time.get_ticks_msec():
		shakeOffset = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * shakePower
		shakeOne = Time.get_ticks_msec() + 35
	
	offset = lerp(offset, shakeOffset, delta)
	

func shake(s, p=50):
	shakeTime = Time.get_ticks_msec() + s * 1000
	shakePower = p
	
