extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D
var direction : float
var prev_mouse_x : float

func _ready():
	sprite.play("default")
	prev_mouse_x = get_global_mouse_position().x

func _physics_process(_delta: float) -> void:
	#get direction based on left or right being pressed
	#TODO: map mouse movement to have parity with this movement
	#TODO: map mobile control buttons to these controls
	direction = Input.get_axis("move_left", "move_right")
	#movement
	if direction:
		velocity.x = direction * Global.PLAYER_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, Global.FRICTION)
	#position.x = get_global_mouse_position().x
	move_and_slide()
