extends Node

@export var waves: Array[Wave] = []
var current_wave_index: int = 0

const groundy = preload("res://Enemies/Groundy.tscn")
var groundyTimer = 0.0

func _ready() -> void:
	load_wave(current_wave_index)

func load_wave(index: int) -> void:
	if index < waves.size():
		groundyTimer = waves[index].groundySpawnTime

func _process(delta: float) -> void:
	if current_wave_index >= waves.size():
		return

	var current_wave = waves[current_wave_index]

	if current_wave.numOfGroundy > 0:
		if groundyTimer > 0:
			groundyTimer -= delta
		else:
			groundyTimer = current_wave.groundySpawnTime
			current_wave.numOfGroundy -= 1  # Stop infinite spawns
			spawn(groundy)

func spawn(OBJ: PackedScene) -> void:
	var spawned = OBJ.instantiate()
	
	# 1. Add to scene tree FIRST so it has a valid spatial context
	get_tree().current_scene.add_child(spawned)
	
	# 2. Set global_position SECOND
	spawned.global_position = Vector2(randf_range(100, 500), 300)
