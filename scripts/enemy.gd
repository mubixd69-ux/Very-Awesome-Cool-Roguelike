extends CharacterBody2D

@export var player_referance : CharacterBody2D
var direction : Vector2
var speed : float = 75

var type : EnemyType:
	set(value):
		type = value
		$AnimatedSprite2D.sprite_frames

func _physics_process(delta: float) -> void:
	velocity = (player_referance.position - position).normalized() * speed
	move_and_collide(velocity * delta)
