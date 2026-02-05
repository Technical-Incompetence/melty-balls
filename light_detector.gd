class_name LightDetector
extends RayCast2D


func set_light_position(light_position: Vector2) -> void:
	target_position = to_local(light_position)

func is_shaded() -> bool:
	if Global.Current_GameState == Global.GameState.READY:
		return true
	return is_colliding()
