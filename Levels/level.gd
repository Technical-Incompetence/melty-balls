class_name Level extends Node2D

## Where lil guys will spawn at.
@export var snowball_spawner: Marker2D
## Where the player node.
@export var birbs: Birbs
## The light node.
@export var sun: Sun
## Number of lil guys that need to reach goal for win condition.
@export var goal_min: int
## Max lil guys that will spawn.
@export var lil_guys_max : int
## The scene for the lil guys, for spawning purposes.
@export var lil_guy_scene: PackedScene

var goal_counter := 0

func _ready():
	spawnLilGuy()
	
func spawnLilGuy():
	var lil_guy: LilGuy = lil_guy_scene.instantiate()
	lil_guy.init(sun)
	add_child(lil_guy)
	lil_guy.global_position = snowball_spawner.global_position
	lil_guy.show()

func _on_goal_zone_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.
	#emit a signal when _body_entered() detects a lilguy/snowball object
	#lilguy / snowballs need to interpret this and queue_free() to remove from memory
	#a counter needs to iterate to count how many have reached goal
	#this goal_counter should global signal to some sort of HUD
