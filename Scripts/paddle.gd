extends StaticBody2D


@export var player : int


func _process(_delta):
	var action_up = "player_" + str(player) + "_up"
	var action_down = "player_" + str(player) + "_down"

	if Input.is_action_pressed(action_up):
		_move_up()
	if Input.is_action_pressed(action_down):
		_move_down()


func _move_up():
	position.y -= 5
	
	if position.y < 15:
		position.y = 15


func _move_down():
	position.y += 5
	
	if position.y > 490:
		position.y = 490
