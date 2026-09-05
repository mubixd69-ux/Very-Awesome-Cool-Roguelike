extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")

@export var fire_rate: float = 0.25
@onready var muzzle: Marker2D = $Marker2D

var can_fire_timer: float = 0.0

func _process(delta: float) -> void:
	if can_fire_timer > 0.0:
		can_fire_timer -= delta
	
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
		

	if Input.is_action_just_pressed("fire") and can_fire_timer <= 0.0:
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation = rotation
		$AudioStreamPlayer2D.play()
		$"../../../Camera2D".shake()
		
		can_fire_timer = fire_rate
