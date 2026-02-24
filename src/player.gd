extends CharacterBody2D

# Prototype 03: Endless Runner with Juice
# Features: Double jump, procedural obstacles, particles, screenshake, speed ramp

@export var jump_velocity: float = -550.0
@export var gravity: float = 1600.0
@export var max_fall_speed: float = 800.0

var is_game_over: bool = false
var score: float = 0.0
var jump_count: int = 0
var max_jumps: int = 2
var game_speed: float = 400.0
var speed_multiplier: float = 1.0

@onready var score_label: Label = $"../UI/ScoreLabel"
@onready var game_over_label: Label = $"../UI/GameOverLabel"
@onready var jump_particles: CPUParticles2D = $JumpParticles
@onready var land_particles: CPUParticles2D = $LandParticles
@onready var camera: Camera2D = $"../Camera2D"

var was_on_floor: bool = false

func _ready() -> void:
	position.x = 150
	is_game_over = false
	score = 0.0
	jump_count = 0
	game_speed = 400.0
	speed_multiplier = 1.0
	update_score_display()
	game_over_label.hide()
	was_on_floor = is_on_floor()

func _physics_process(delta: float) -> void:
	if is_game_over:
		if Input.is_action_just_pressed("ui_accept"):
			restart_game()
		return
	
	# Apply gravity with terminal velocity
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
	
	# Handle jump (double jump enabled)
	if Input.is_action_just_pressed("ui_accept"):
		if jump_count < max_jumps:
			velocity.y = jump_velocity
			jump_count += 1
			trigger_jump_particles()
			trigger_screenshake(2.0, 0.1)
	
	# Reset jump count when landing
	if is_on_floor() and not was_on_floor:
		jump_count = 0
		trigger_land_particles()
		trigger_screenshake(1.0, 0.05)
	
	was_on_floor = is_on_floor()
	
	# Keep player at fixed X (auto-run illusion)
	position.x = 150
	velocity.x = 0
	
	move_and_slide()
	
	# Update score and speed
	score += delta * 10 * speed_multiplier
	speed_multiplier = 1.0 + (score / 1000.0)  # Speed increases with score
	update_score_display()

func update_score_display() -> void:
	if score_label:
		score_label.text = "SCORE: %d" % int(score)

func trigger_jump_particles() -> void:
	if jump_particles:
		jump_particles.emitting = true

func trigger_land_particles() -> void:
	if land_particles:
		land_particles.emitting = true

func trigger_screenshake(intensity: float, duration: float) -> void:
	if camera:
		camera.offset = Vector2(
			randf_range(-intensity, intensity),
			randf_range(-intensity, intensity)
		)
		await get_tree().create_timer(duration).timeout
		camera.offset = Vector2.ZERO

func game_over() -> void:
	if is_game_over:
		return
	is_game_over = true
	trigger_screenshake(8.0, 0.3)
	if game_over_label:
		game_over_label.show()
		game_over_label.text = "GAME OVER\nScore: %d\nPress SPACE to restart" % int(score)
	# Slow motion death effect
	Engine.time_scale = 0.3
	await get_tree().create_timer(0.5).timeout
	Engine.time_scale = 1.0

func restart_game() -> void:
	position.y = 500
	velocity = Vector2.ZERO
	is_game_over = false
	score = 0.0
	jump_count = 0
	game_speed = 400.0
	speed_multiplier = 1.0
	Engine.time_scale = 1.0
	update_score_display()
	game_over_label.hide()
	get_tree().call_group("obstacles", "reset")
	get_tree().call_group("obstacle_spawner", "restart")
