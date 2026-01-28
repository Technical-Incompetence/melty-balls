extends Node2D

# We need this to be in a parent Node2D because Control nodes don't have global_rotation
func _process(_delta: float) -> void:
	global_rotation = 0
	scale = Vector2(1.0, 1.0)
