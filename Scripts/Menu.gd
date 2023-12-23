extends CanvasLayer

signal start_game(players)

var game_started = false
var players: int


func _on_top_button_pressed():
	if game_started:
		pass
	else:
		players = 1
		$TopButton.texture_normal = load("res://Assests/Images/RestartButton.png")
		$BottomButton.texture_normal = load("res://Assests/Images/TwoPlayersButton.png")
		game_started = true
		
	start_game.emit(players)


func _on_bottom_button_pressed():
	if game_started:
		if players == 1:
			players = 2
			$BottomButton.texture_normal = load("res://Assests/Images/SinglePlayerButton.png")
		else:
			players = 1
			$BottomButton.texture_normal = load("res://Assests/Images/TwoPlayersButton.png")
	else:
		players = 2
		$TopButton.texture_normal = load("res://Assests/Images/RestartButton.png")
		$BottomButton.texture_normal = load("res://Assests/Images/SinglePlayerButton.png")
		game_started = true
		
	start_game.emit(players)
