extends Node2D

var score = Vector2(0, 0)
signal restarted(player)


func _process(delta):
	var ball_pos = $Ball.position.x
	
	if ball_pos < 0:
		score[1] += 1
		restarted.emit(1)
	elif ball_pos > 1024:
		score[0] += 1
		restarted.emit(2)
