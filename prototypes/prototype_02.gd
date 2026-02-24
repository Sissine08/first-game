extends CharacterBody2D

# Prototype 02: Endless Runner
# Goal: Auto-scroll, dodge obstacles, score system

@export var jump_velocity: float = -500.0
@export var gravity: float = 1500.0

var is_game_over: bool = false
var score: float = 0.0

@onready var score_label: Label = $"../UI/ScoreLabel"
@onready var game_over_label: Label = $"../UI/GameOverLabel"

func _ready() -> void:
	# Lock player X position (auto-run)
	position.x = 150
	is_game_over = false
	score = 0.0
	update_score_display()
	game_over_label.hide()

func _physics_process(delta: float) -> void:
	if is_game_over:
		if Input.is_action_just_pressed("ui_accept"):
			restart_game()
		return
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	# Keep player at fixed X (auto-run illusion)
	position.x = 150
	velocity.x = 0
	
	move_and_slide()
	
	# Update score (distance survived)
	score += delta * 10
	update_score_display()

func update_score_display() -> void:
	if score_label:
		score_label.text = "SCORE: %d" % int(score)

func game_over() -> void:
	is_game_over = true
	if game_over_label:
		game_over_label.show()
		game_over_label.text = "GAME OVER\nScore: %d\nPress SPACE to restart" % int(score)

func restart_game() -> void:
	# Reset player
	position.y = 500
	velocity = Vector2.ZERO
	is_game_over = false
	score = 0.0
	update_score_display()
	game_over_label.hide()
	
	# Reset obstacles
	get_tree().call_group("obstacles", "reset")
