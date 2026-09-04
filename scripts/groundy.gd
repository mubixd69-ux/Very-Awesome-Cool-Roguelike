extends CharacterBody2D

@export var speed: float = 150.0
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
