extends Control


func _on_exit_button_pressed() -> void:
	SignalBus.loadMainMenu.emit()
