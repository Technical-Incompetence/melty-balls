class_name Level extends Node2D

## Where lil guys will spawn at.
@export var lilguy_spawn: Marker2D
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

@onready var spawn_area : Area2D = $lilguy_spawn/lilguy_spawn_area
var lil_guy: LilGuy

var goal_counter := 0
var lilguy_counter := 0 
var lilguys_melted := 0
var max_lilguys_to_lose = lil_guys_max - goal_min

func _ready():
	updateHud()
	SignalBus.goalCountUp.connect(goalStateCounter)
	SignalBus.meltCountUp.connect(meltCounter)

func _physics_process(_delta: float):
	#spawn lilguys when spawn zone is clear and lilguy max not reached
	if spawnZoneIsClear() && lilguy_counter < lil_guys_max:
		spawnLilGuy()
		lilguy_counter += 1
		updateHud()
	#trigger game over / fail state when lost too many lilguys
	if lilguys_melted > max_lilguys_to_lose:
		loseState()
	
func spawnLilGuy():
	lil_guy = lil_guy_scene.instantiate()
	#NOTE: may not be needed, but instantiating lilguys with unique names based off the counter
	#could potentially have a use case in future scope?  otherwise TODO: delete me
	lil_guy.set_name("LilGuys_"+ str(lilguy_counter))
	#needed for lil_guy to detect lightsource
	lil_guy.init(sun)
	lil_guy.global_position = lilguy_spawn.global_position
	add_child(lil_guy)
	lil_guy.show()
	
func spawnZoneIsClear() -> bool:
	for area in spawn_area.get_overlapping_areas():
		if area.is_in_group("lilguys"):
			return false
	return true
	
func goalStateCounter():
	goal_counter += 1
	updateHud()
	if goal_counter == goal_min:
		#TODO proper victory screen before immediately loading next level
		Global.Current_Level += 1
		if Global.Current_Level <= 2: #current max levels that exist
			SignalBus.loadLevel.emit(Global.Current_Level)
		else:
			SignalBus.loadMainMenu.emit() #TODO: proper THE END state

func meltCounter():
	lilguys_melted += 1
	updateHud()
		
func loseState():
	#TODO: proper gameover state+UI with restart or main menu button
	SignalBus.loadMainMenu.emit()
	
func updateHud():
	SignalBus.updateHud.emit(goal_counter, goal_min, lil_guys_max-lilguy_counter, lilguys_melted)
		
#TODO: UI child node for level class for HUD? such as lilguys left to spawn, current goals, etc?
