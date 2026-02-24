extends Area2D

# Obstacle that moves left and triggers game over on collision

@export var move_speed: float = 400.0
@export var spawn_x: float = 1400.0

var active: bool = false

func _ready() -> void:
	add_to_group("obstacles")
	reset()

func _process(delta: float) -> void:
	if not active:
		return
	
	# Move left
	position.x -= move_speed * delta
	
	# Despawn if off screen
	if position.x < -100:
		reset()

func reset() -> void:
	active = false
	position.x = spawn_x + randf_range(0, 500)  # Random delay before spawn
	position.y = 550  # Ground level

func activate() -> void:
	active = true

func _on_area_entered(area: Area2D) -> void:
	# Check if collided with player
	if area.is_in_group("player"):
		area.get_parent().game_over()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	activate()
