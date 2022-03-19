extends KinematicBody2D

var spd = 50;
var velocity = Vector2.ZERO
onready var _animator := $AnimationPlayer

func input():
	if Input.is_action_pressed("ui_right"):
		_animator.play("Player_Walk")
		velocity.x = spd
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		_animator.play("Player_Walk")
		velocity.x = -spd
		$Sprite.flip_h = true
	else:
		_animator.play("Player_Idle")
		velocity.x = 0
		
	velocity.normalized() * spd

func _physics_process(delta):
	input()
	move_and_slide(velocity)

func ready():
	pass
