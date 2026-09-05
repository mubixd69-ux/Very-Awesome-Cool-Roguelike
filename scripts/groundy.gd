extends CharacterBody2D

# 1. Declare the signal at the top
signal enemy_died

@export var speed: float = 150.0
@export var max_health: int = 50
var current_health: int
var player: Node2D = null

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	current_health = max_health

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(player):
		player = get_tree().current_scene.find_child("player", true, false)
		if not is_instance_valid(player):
			return 

	var direction: Vector2 = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	if player.global_position.x < global_position.x:
		animated_sprite.flip_h = true
	elif player.global_position.x > global_position.x:
		animated_sprite.flip_h = false
	
	if animated_sprite.animation != "hurt":
		animated_sprite.play("default")

func take_damage(amount: int) -> void:
	animated_sprite.play("hurt")
	current_health -= amount
	if current_health <= 0:
		die()
		
func die() -> void:
	animated_sprite.play("hurt") 
	
	# 2. Emit the signal when dying! (No spawner reference needed)
	emit_signal("enemy_died")
	
	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(25)

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "hurt":
		animated_sprite.play("default")
		if current_health <= 0:
			die()
