extends CharacterBody2D

@export var speed: float = 200.0
@export var sprint_speed: float = 400.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
        "move_down"
	)
	
	var current_speed := speed
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
		
	velocity = direction * current_speed
	move_and_slide()
