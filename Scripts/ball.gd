extends CharacterBody2D


var _stored_velocity: Vector2


func _ready():
	get_parent().restarted.connect(_restart)
	get_parent().paused.connect(_pause)
	get_parent().resumed.connect(_resume)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if velocity.x > 0:
			velocity.x += 10
		else:
			velocity.x -= 10
		
		var collider = collision.get_collider()
		
		if collider.name == "Player1" or collider.name == "Player2":
			var paddle = collider as StaticBody2D
			var paddle_pos = paddle.position
			var collision_pos = collision.get_position()
			var pos_on_paddle = collision_pos.y - paddle_pos.y
			
			if (pos_on_paddle < 47.5):
				velocity = Vector2(velocity.x * -1, (47.5 - pos_on_paddle) * -4)
			else:
				velocity = Vector2(velocity.x * -1, (pos_on_paddle - 47.5) * 4)
		else:
			velocity = velocity.bounce(collision.get_normal())
			
		$AudioStreamPlayer2D.play()


func _restart(player):
	visible = true
	position = Vector2(505, randi_range(15, 585))
	velocity = Vector2(350, randi_range(-170, 170))
	
	if player == 1:
		velocity.x *= -1


func _pause():
	_stored_velocity = velocity
	velocity = Vector2(0, 0)
	visible = false


func _resume():
	velocity = _stored_velocity
