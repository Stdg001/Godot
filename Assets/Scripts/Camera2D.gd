extends Camera2D
# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  get_parent().global_position.x > global_position.x:
		global_position.x = get_parent().global_position.x
