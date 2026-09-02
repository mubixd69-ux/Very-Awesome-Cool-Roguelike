extends CharacterBody2D

@export var movement_speed : float = 500
var character_direction : Vector2
var hand_direction : Vector2
var hand_offset = 17
var hand_angle = 0

func _physics_process(delta: float) -> void:
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("down", "up")
	character_direction = character_direction.normalized()
	hand_direction = (get_global_mouse_position()-$".".position).normalized()
	$Hand.position.x = hand_direction.x * hand_offset
	$Hand.position.y = -6 + hand_direction.y * hand_offset
	hand_angle = rad_to_deg(atan2(hand_direction.y, hand_direction.x))
	$Hand.rotation_degrees = hand_angle
	
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
	
