extends Control

@onready var music_slider : HSlider = $MarginContainer/HBoxContainer/VBoxContainer/musicVolumeContainer/VBoxContainer/HSlider
@onready var screen_header : RichTextLabel = $"MarginContainer/HBoxContainer/VBoxContainer/screen header"
@onready var screen_dropdown : OptionButton = $MarginContainer/HBoxContainer/VBoxContainer/OptionButton

var music_bus_index : int
var current_screen_mode : int
var screen_popupmenu : PopupMenu

func _ready():
	if OS.get_name() == 'Web':
		#hide screen settings if in web mode
		screen_header.hide()
		screen_dropdown.hide()
	else:
		#ensure default option matches initial display settings
		current_screen_mode = DisplayServer.window_get_mode()
		if current_screen_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			screen_dropdown.select(1) #"Fullscreen Mode" (index 1)
		else:
			screen_dropdown.select(0) #"Windowed Mode" (index 0)
		screen_popupmenu = screen_dropdown.get_popup()
		screen_popupmenu.add_theme_font_size_override("font_size", 64)
	music_bus_index = AudioServer.get_bus_index("Music")

func _on_exit_button_pressed() -> void:
	hide()

func _on_h_slider_value_changed(value: float) -> void:
	#convert slider value (0 to 1) to decibels and set the music volume
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))

func _on_minus_pressed() -> void:
	#button for volume down
	if music_slider.value != 0.0:
		music_slider.value -= 0.1

func _on_plus_pressed() -> void:
	#button for volume up
	if music_slider.value != 1.0:
		music_slider.value += 0.1

#window mode dropdown
func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		#Windowed mode
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif index == 1:
		 #Fullscreen mode
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
