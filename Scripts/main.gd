extends Node2D


signal restarted(player)
signal paused
signal resumed

var _score = Vector2(0, 0)
var _game_started = false


func _ready():
	$Menu.game_started.connect(_start_game)


func _process(_delta):
	var ball_pos = $Ball.position.x
	
	if ball_pos < 0:
		_score[1] += 1
		restarted.emit(1)
		_update_score_display(2)
	elif ball_pos > 1024:
		_score[0] += 1
		restarted.emit(2)
		_update_score_display(1)
	
	if Input.is_action_just_pressed("open_menu"):
		if $Menu.is_visible():
			_resume()
		else:
			_pause()


func _update_score_display(player):
	var score_to_update = _score[player-1]
	
	if score_to_update != 0:
		$AudioStreamPlayer2D.play()
	
	if score_to_update >= 10:
		var tens = floor(score_to_update / 10)
		score_to_update = int(score_to_update) % 10
		
		var tens_node_name = "Player" + str(player) + "ScoreTens"
		var tens_node = get_node(tens_node_name) as TextureRect
		tens_node.texture = load("res://Assests/Images/" + str(tens) + ".png")
		
	var ones_node_name = "Player" + str(player) + "ScoreOnes"
	var ones_node = get_node(ones_node_name) as TextureRect
	ones_node.texture = load("res://Assests/Images/" + str(score_to_update) + ".png")


func _start_game(players):
	var node_to_remove = get_node("Player2")
	remove_child(node_to_remove)
	
	_create_player_2_paddle(players)
	_reset_score()
	
	$Player1.position = Vector2(0, 252.5)
	$Ball.position = Vector2(505, 277.5)
	
	$Menu.hide()
	$StartTimer.start()
	await $StartTimer.timeout
	
	restarted.emit(2)
	_game_started = true


func _create_player_2_paddle(players):
	var paddle: StaticBody2D
	
	if players == 1:
		paddle = load("res://Scenes/ComputerPaddle.tscn").instantiate()
	else:
		paddle = load("res://Scenes/Paddle.tscn").instantiate()
		paddle.player = 2
		
	paddle.position = Vector2(1004, 252.2)
	paddle.name = "Player2"
	add_child(paddle)


func _reset_score():
	_score = Vector2(0, 0)
	_update_score_display(1)
	_update_score_display(2)


func _pause():
	$Menu.show()
	paused.emit()


func _resume():
	if _game_started:
		$Menu.hide()
		$Ball.visible = true
		$StartTimer.start()
		await $StartTimer.timeout
		resumed.emit()
