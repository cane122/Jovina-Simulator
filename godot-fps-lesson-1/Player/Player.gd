extends KinematicBody

export var speed = 25
export var acceleration = 5
export var gravity = 1
export var jump_power = 30
export var mouse_sensitivity = 0.1
export var double_jump = true
var health = 100
var cooldown_rate = 10

onready var head = $Head
onready var camera = $Head/Camera
onready var gun1 = $Head/Camera/t19
onready var gun2 = $Head/Camera/Melee
onready var gun3 = $"Head/Camera/ED-19"
var current_weapon = 1

var velocity = Vector3()
var camera_x_rotation = 0

signal health_changed(newHealth)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90: 
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	
	change_weapon()
	
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	
	
	var gravity_resistance = get_floor_normal() if is_on_floor() else Vector3.UP
	velocity -= gravity_resistance * gravity
	if is_on_floor():
		double_jump = true
	if Input.is_action_just_pressed("jump") and (is_on_floor() or double_jump):
		if(is_on_floor() == false):
			double_jump = false
		else:
			double_jump = true
		velocity.y += jump_power
	velocity = move_and_slide(velocity, Vector3.UP)

func change_weapon():
	if Input.is_action_just_pressed("switch_weapon_1"):
		current_weapon = 1
		
		yield(get_tree().create_timer(cooldown_rate), "timeout")
	elif Input.is_action_just_pressed("switch_weapon_2"):
		current_weapon = 2
		
		yield(get_tree().create_timer(cooldown_rate), "timeout")
	elif Input.is_action_just_pressed("switch_weapon_3"):
		current_weapon = 3
		
		yield(get_tree().create_timer(cooldown_rate), "timeout")
		
	if current_weapon == 1:
		gun1.visible = true
	else:
		gun1.visible = false

	if current_weapon == 2:
		gun2.visible = true
	else:
		gun2.visible = false

	if current_weapon == 3:
		gun3.visible = true
	else:
		gun3.visible = false
	
func takeDamage(damage):
	health -= damage
	emit_signal("health_changed",health)
	self.get_parent()
	if health <=0:
		$AudioStreamPlayer.play()
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().quit()
	



