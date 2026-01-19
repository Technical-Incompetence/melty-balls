extends Control

@onready var hud_text := $RichTextLabel

func _ready():
	hide()
	SignalBus.updateHud.connect(update_display)

func update_display(current_goals : int, goals_needed : int, lilguys_remaining : int, lilguys_melted : int):
	hud_text.text = "\n\nGoals: " + str(current_goals) + " / " + str(goals_needed) + "\nLil Guys Remaining: " + str(lilguys_remaining) + "\nLil Guys Melted: " + str(lilguys_melted)
