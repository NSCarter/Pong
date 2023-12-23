extends CanvasLayer


signal game_started(players)

var _game_started = false
var _players: int


func _on_top_button_pressed():
	if _game_started:
		pass
	else:
		_players = 1
		$TopButton.texture_normal = load("res://Assests/Images/RestartButton.png")
		$BottomButton.texture_normal = load("res://Assests/Images/TwoPlayersButton.png")
		_game_started = true
		
	game_started.emit(_players)


func _on_bottom_button_pressed():
	if _game_started:
		if _players == 1:
			_players = 2
			$BottomButton.texture_normal = load("res://Assests/Images/SinglePlayerButton.png")
		else:
			_players = 1
			$BottomButton.texture_normal = load("res://Assests/Images/TwoPlayersButton.png")
	else:
		_players = 2
		$TopButton.texture_normal = load("res://Assests/Images/RestartButton.png")
		$BottomButton.texture_normal = load("res://Assests/Images/SinglePlayerButton.png")
		_game_started = true
		
	game_started.emit(_players)
