extends CharacterBody2D

@export var movement_speed : float = 500
var character_direction : Vector2

func _physics_process(delta: float) -> void:
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("down", "up")
	character_direction = character_direction.normalized()
	
	# flip
	if character_direction.x > 0: %AnimatedSprite2D.flip_h = false
	elif character_direction.x < 0: %AnimatedSprite2D.flip_h = true
	
	if character_direction:
		velocity = character_direction * movement_speed
		if %AnimatedSprite2D.animation != "run": %AnimatedSprite2D.animation = "run"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if %AnimatedSprite2D.animation != "idle": %AnimatedSprite2D.animation = "idle"
	
	move_and_slide()
	
