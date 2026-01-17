extends Area2D

@onready var sprite := $AnimatedSprite2D

func _ready():
	sprite.play("default")

func _process(_delta: float) -> void:
	position.x = get_global_mouse_position().x
