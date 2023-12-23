extends StaticBody2D


var _ball: CharacterBody2D
var _paused = false


func _ready():
	_ball = get_parent().get_node("Ball")
	get_parent().paused.connect(func(): _paused = true)
	get_parent().resumed.connect(func(): _paused = false)


func _process(delta):
	if not _paused:
		var success = randi_range(1, 4) < 4
		
		if success:
			var ball_pos = _ball.position.y
			
			if ball_pos < position.y:
				_move_up()
			elif ball_pos > position.y + 47.5:
				_move_down()


func _move_up():
	position.y -= 3
	
	if position.y < 15:
		position.y = 15


func _move_down():
	position.y += 3
	
	if position.y > 490:
		position.y = 490
