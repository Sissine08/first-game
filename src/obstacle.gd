extends Area2D

# Obstacle that moves left and triggers game over on collision

@export var base_speed: float = 450.0
@export var spawn_x: float = 1400.0

var active: bool = true
var current_speed: float = 450.0

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	add_to_group("obstacles")

func _process(delta: float) -> void:
	if not active:
		return
	
	# Move left
	position.x -= current_speed * delta
	
	# Despawn if off screen
	if position.x < -100:
		queue_free()

func set_speed(multiplier: float) -> void:
	current_speed = base_speed * multiplier

func _on_body_entered(body: Node2D) -> void:
	# Check if collided with player
	if body.is_in_group("player"):
		body.game_over()
