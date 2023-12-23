extends StaticBody2D

var ball: CharacterBody2D
var paused = false


func _ready():
	ball = get_parent().get_node("Ball")
	get_parent().paused.connect(func(): paused = true)
	get_parent().resumed.connect(func(): paused = false)


func _process(delta):
	if not paused:
		var success = randi_range(1, 4) < 4
		
		if success:
			var ball_pos = ball.position.y
			
			if ball_pos < position.y:
				move_up()
			elif ball_pos > position.y + 47.5:
				move_down()


func move_up():
	position.y -= 3
	
	if position.y < 15:
		position.y = 15


func move_down():
	position.y += 3
	
	if position.y > 490:
		position.y = 490
