extends Control

@export var label: RichTextLabel

func _ready() -> void:
	label.install_effect(preload("res://wave_effect.gd").new())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start_level"):
		if is_start_allowed():
			SignalBus.updateGameState.emit(Global.GameState.PLAYING)
			hide()

func is_start_allowed() -> bool:
	return Global.Current_GameState == Global.GameState.READY
