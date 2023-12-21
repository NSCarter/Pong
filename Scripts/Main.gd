extends Node2D

var score = Vector2(0, 0)
signal restarted(player)


func _process(_delta):
	var ball_pos = $Ball.position.x
	
	if ball_pos < 0:
		score[1] += 1
		restarted.emit(1)
		_update_score_display(2)
	elif ball_pos > 1024:
		score[0] += 1
		restarted.emit(2)
		_update_score_display(1)


func _update_score_display(player):
	var score_to_update = score[player-1]
	
	if score_to_update >= 10:
		var tens = floor(score_to_update / 10)
		score_to_update = int(score_to_update) % 10
		
		var tens_node_name = "Player" + str(player) + "ScoreTens"
		var tens_node = get_node(tens_node_name) as TextureRect
		tens_node.texture = load("res://Assests/Images/" + str(tens) + ".png")
		
	var ones_node_name = "Player" + str(player) + "ScoreOnes"
	var ones_node = get_node(ones_node_name) as TextureRect
	ones_node.texture = load("res://Assests/Images/" + str(score_to_update) + ".png")
