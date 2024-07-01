extends CharacterBody2D

@onready var _AP = $AnimationPlayer
@onready var _SP = $Sprite2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var WALL_PUSHBACK = -2500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
	if (is_on_wall_only() and direction) and velocity.y > 0:
		_AP.play('wall_slide')
		velocity.y = (gravity * delta) / 0.2
	elif not is_on_floor():
		velocity.y += gravity * delta

	if direction:
		velocity.x = direction * SPEED
		_SP.flip_h = false if (direction == 1) else true
		_AP.play('walk')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_AP.play('idle')

	if Input.is_action_just_pressed('dash'):
		velocity.x = (SPEED * 4 * direction) if direction else SPEED * 4
		_AP.play('dash')
			
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			_AP.play('jump')
		
		if direction and is_on_wall_only():
			velocity.y = SPEED * direction
			_AP.play('jump')
			
	move_and_slide()
