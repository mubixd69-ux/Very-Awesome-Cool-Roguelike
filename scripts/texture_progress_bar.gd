extends TextureProgressBar

@onready var player = $"../../player"

func _ready() -> void:
	player.healthChanged.connect(update)
	update()

func update():
	value = player.current_health * 100 / player.max_health
