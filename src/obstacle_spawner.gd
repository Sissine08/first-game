extends Node2D

# Procedural Obstacle Spawner
# Generates obstacles infinitely with increasing difficulty

@export var obstacle_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var min_interval: float = 0.8
@export var spawn_y: float = 550.0

var time_since_spawn: float = 0.0
var current_interval: float = 2.0
var game_started: bool = false

func _ready() -> void:
	add_to_group("obstacle_spawner")
	game_started = true
	current_interval = spawn_interval
	# Spawn first obstacle immediately
	spawn_obstacle()

func _process(delta: float) -> void:
	if not game_started:
		return
	
	time_since_spawn += delta
	
	# Get faster as score increases
	var player = get_node_or_null("../Player")
	if player:
		var score_factor = 1.0 + (player.score / 2000.0)
		current_interval = max(min_interval, spawn_interval / score_factor)
	
	if time_since_spawn >= current_interval:
		spawn_obstacle()
		time_since_spawn = 0.0

func spawn_obstacle() -> void:
	if not obstacle_scene:
		return
	
	var obstacle = obstacle_scene.instantiate()
	add_child(obstacle)
	
	# Randomize height slightly for variety
	var height_variation = randf_range(-30, 30)
	obstacle.position = Vector2(1400, spawn_y + height_variation)
	
	# Randomize speed slightly
	if obstacle.has_method("set_speed"):
		var speed_variation = randf_range(0.9, 1.1)
		obstacle.set_speed(speed_variation)

func restart() -> void:
	# Clear existing obstacles
	for child in get_children():
		if child.is_in_group("obstacles"):
			child.queue_free()
	
	time_since_spawn = 0.0
	current_interval = spawn_interval
	spawn_obstacle()

func stop() -> void:
	game_started = false
