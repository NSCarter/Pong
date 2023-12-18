extends Node2D

@export var player : int


func _process(_delta):
	if player == 1:
		if Input.is_action_pressed("player_1_down"):
			move_down()
		if Input.is_action_pressed("player_1_up"):
			move_up()
	elif player == 2:
		if Input.is_action_pressed("player_2_down"):
			move_down()
		if Input.is_action_pressed("player_2_up"):
			move_up()

func move_up():
	position.y -= 5
	
	if position.y < 15:
		position.y = 15


func move_down():
	position.y += 5
	
	if position.y > 490:
		position.y = 490
