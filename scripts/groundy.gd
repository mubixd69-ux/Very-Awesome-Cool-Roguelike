extends CharacterBody2D

@export var speed: float = 150.0
@export var max_health: int = 50

var current_health: int

var player: Node2D = null

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(player):
		# Search the active scene for a node named "Player"
		player = get_tree().current_scene.find_child("player", true, false)
		if not is_instance_valid(player):
			return # Still no player found, wait for next frame

	var direction: Vector2 = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
func take_damage(amount: int) -> void:
	current_health -= amount
	
	
	if current_health <= 0:
		die()
		
func die() -> void:
		queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(25)
