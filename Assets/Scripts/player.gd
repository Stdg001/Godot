extends CharacterBody2D

@onready var _AP = $AnimationPlayer
@onready var _SP = $Sprite2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var WALL_PUSHBACK = -2500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if direction_x and not is_on_wall():
		
		Timer.
		
		
		velocity.x = direction_x * SPEED
		_SP.flip_h = false if (direction_x == 1) else true
		_AP.play('walk')
		print('peocess 19')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_AP.play('idle')
	
	if (direction_y and direction_x) and is_on_wall():
		_AP.play('wall_walking')
		velocity.y = SPEED * direction_y
	elif direction_x and is_on_wall():
		_AP.play('wall_idle')
		velocity.y = 0
		
		if direction_y:
			_AP.play("wall_slide")
	
	if Input.is_action_just_pressed('dash'):
		velocity.x = (SPEED * 4 * direction_x) if direction_x else SPEED * 4
		_AP.play('dash')

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			_AP.play('jump')
	move_and_slide()
