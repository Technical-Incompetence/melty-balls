class_name LilGuy
extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D
@onready var light_detector: LightDetector = $LightDetector

var light: PointLight2D

func _ready():
	sprite.play("default")

func _process(_delta: float) -> void:
	if light:
		light_detector.set_light_position(light.global_position)
