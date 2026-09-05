extends CharacterBody2D

@export var max_health: int = 100
var current_health: int

signal healthChanged

@onready var health_bar: TextureProgressBar = $canvaslayer/Healthbar

@export var movement_speed : float = 500
var character_direction : Vector2
var hand_direction : Vector2
var hand_offset = 15
var hand_angle = 0

func _physics_process(delta: float) -> void:
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("down", "up")
	character_direction = character_direction.normalized()
	hand_direction = (get_global_mouse_position()-$".".position).normalized()
	$Hand.position.x = hand_direction.x * hand_offset
	$Hand.position.y = -6 + hand_direction.y * hand_offset
	#$Hand.look_at(get_global_mouse_position())
	
	
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
	
	# Player Health
func _ready() -> void:
		current_health = max_health
		
		if health_bar:
			health_bar.max_value = max_health
			health_bar.value = current_health

func take_damage(amount: int) -> void:
	current_health -= amount
	healthChanged.emit()
	
	if health_bar:
		health_bar.value = current_health
	if current_health <= 0:
		die()
		
func die() -> void:
		print("player die")
	
