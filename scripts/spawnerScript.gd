extends Node

@export var waves: Array[Wave] = []
var current_wave_index: int = 0

const groundy = preload("res://Enemies/Groundy.tscn")
var groundyTimer = 0.0
const smoldy = preload("res://Enemies/Smoldy.tscn")
var smoldyTimer = 0.0

# Runtime tracking variables (this fixes the error!)
var groundy_to_spawn: int = 0
var smoldy_to_spawn: int = 0
var enemies_alive: int = 0

func _ready() -> void:
	load_wave(current_wave_index)

func load_wave(index: int) -> void:
	if index < waves.size():
		print("Loading Wave: ", index)
		current_wave_index = index
		var wave = waves[index]
		
		groundy_to_spawn = wave.numOfGroundy
		smoldy_to_spawn = wave.numOfSmoldy
		groundyTimer = wave.groundySpawnTime
		smoldyTimer = wave.smoldySpawnTime
	else:
		print("All waves completed! You win!")

func _process(delta: float) -> void:
	if current_wave_index >= waves.size():
		return

	var wave = waves[current_wave_index]

	# --- SPAWN GROUNDY ---
	if groundy_to_spawn > 0:
		if groundyTimer > 0:
			groundyTimer -= delta
		else:
			groundyTimer = wave.groundySpawnTime
			groundy_to_spawn -= 1  
			spawn(groundy)
			
	# --- SPAWN SMOLDY ---
	if smoldy_to_spawn > 0:
		if smoldyTimer > 0:
			smoldyTimer -= delta
		else:
			smoldyTimer = wave.smoldySpawnTime
			smoldy_to_spawn -= 1
			spawn(smoldy)
			
	# --- CHECK IF WAVE IS CLEARED ---
	if groundy_to_spawn == 0 and smoldy_to_spawn == 0 and enemies_alive <= 0:
		current_wave_index += 1
		load_wave(current_wave_index)

func spawn(OBJ: PackedScene) -> void:
	var spawned = OBJ.instantiate()
	
	# Connect to the enemy's signal the exact second it's created
	spawned.enemy_died.connect(_on_enemy_died)
	
	get_tree().current_scene.add_child(spawned)
	enemies_alive += 1
	
	var playerPos = $"../player".position
	var randAngle = randf_range(0, 360)
	var offset = 300
	var x = sin(deg_to_rad(randAngle)) * offset + playerPos.x
	var y = cos(deg_to_rad(randAngle)) * offset + playerPos.y
	
	spawned.global_position = Vector2(x, y)

func _on_enemy_died() -> void:
	enemies_alive -= 1
	print("An enemy died! Remaining alive: ", enemies_alive)
