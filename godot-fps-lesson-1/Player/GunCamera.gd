extends Camera3D

@export var camera_path : NodePath

var camera : Camera3D

func _ready():
	camera = get_node(camera_path)

func _process(delta):
	global_transform = camera.global_transform
	
