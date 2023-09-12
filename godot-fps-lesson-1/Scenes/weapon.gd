extends Node

class_name Weapon

@export var fire_rate = 0.12
@export var clip_size = 40
@export var reload_rate = 1
var block = false
var cooldown_rate = 10
var current_weapon = 1

@onready var ammo_label = $"/root/World3D/UI/Label"
@onready var raycast = $"../../Head/Camera3D/RayCast3D"
var current_ammo = 0
var weapon = 1
var can_fire = true
var reloading = false

func set_fire_rate(x):
	fire_rate = x;

func set_clip_size(x):
	clip_size = x;

func set_reload_rate(x):
	reload_rate = x;

func get_current_ammo():
	return current_ammo

func set_current_ammo(c):
	current_ammo = c
	
func _ready():
	current_ammo = clip_size
	
func stop_sound():
	$AudioStreamPlayer.stop()
	
func _process(delta):
	if Input.is_action_just_pressed("switch_weapon_1"):
		current_weapon = 1
		
		block= true
		await get_tree().create_timer(cooldown_rate).timeout
		stop_sound()
	elif Input.is_action_just_pressed("switch_weapon_2"):
		current_weapon = 2
		stop_sound()
		
		block= true
		await get_tree().create_timer(cooldown_rate).timeout
	elif Input.is_action_just_pressed("switch_weapon_3"):
		current_weapon = 3
		stop_sound()
		block= true
		await get_tree().create_timer(cooldown_rate).timeout
		
	if reloading:
		ammo_label.set_text("Reloading...")
	else:
		if(current_weapon == weapon):
			ammo_label.set_text("%d / %d" % [current_ammo, clip_size])
	if(Input.is_action_just_pressed("primary_fire")):
		block = false
	if (Input.is_action_pressed("primary_fire")) and can_fire:
		if (current_ammo > 0 and not reloading) and not block:
			fire()
	
	if Input.is_action_just_pressed("reload") and not reloading:
		reload()
		
func check_collision(damage):
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.takeDamage(damage)
			print("Killed " + collider.name)

func fire():
	pass
	
func reload():
	print("Reloading")
	reloading = true
	await get_tree().create_timer(reload_rate).timeout
	current_ammo = clip_size
	reloading = false
	print("Reload complete")
