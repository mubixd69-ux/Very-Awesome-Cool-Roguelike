extends Area2D

const SPEED: int = 150

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	var target = area.get_parent()
	if target and target.has_method("take_damage"):
		target.take_damage(25)
	print(1)	
	queue_free()
	
