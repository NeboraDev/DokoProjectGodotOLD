extends KinematicBody2D

const UP_DIRECTION := Vector2.UP  # Allows movement for the up direction

export var spd := 60.0
export var velocity := Vector2.ZERO
export var jump_height := 40.0
export var jump_time_to_peak := 0.4
export var jump_time_to_descent := 0.38

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

onready var player : Sprite = $Sprite
onready var animation : AnimationPlayer = $AnimationPlayer

func _physics_process(delta : float) -> void:
	var is_idle := is_on_floor() and is_zero_approx(velocity.x)
	var is_walking := is_on_floor() and !is_zero_approx(velocity.x)
	var is_jumping := Input.is_action_just_pressed("ui_jump") and is_on_floor()
	var is_falling := velocity.y > 0.0 and !is_on_floor()
	
	var horizontal_direction = ( #Grabs a value 1 through -1 for movement.
		Input.get_action_strength("ui_right") - 
		Input.get_action_strength("ui_left")
	)
	
	if horizontal_direction == 1:  # Changes the user's view direction
		player.flip_h = false
	elif horizontal_direction == -1:
		player.flip_h = true;
	
	if Input.is_action_pressed("ui_run"):
		spd = 80
		animation.playback_speed
	else:
		spd = 60
	
	velocity.x = horizontal_direction * spd  # Movement
	velocity.y += get_gravity() * delta  # Gravity
	jump(is_jumping)
	
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
	_animation(is_idle, is_walking, is_jumping, is_falling)

func get_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump(jumping):
	if jumping:
		velocity.y = jump_velocity

func _animation(idle, walk, jump, fall):
	if idle:
		animation.play("Player_Idle")
	elif walk:
		animation.play("Player_Walk")
	elif jump:
		animation.play("Player_Jump")
	elif fall:
		animation.play("Player_Fall")
