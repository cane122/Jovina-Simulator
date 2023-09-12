extends Weapon

@export var fire_range = 2000

func _ready():
	weapon = 1
	raycast.target_position = Vector3(0, 0, -fire_range)

func fire():
	if current_weapon == 1:
		$AudioStreamPlayer.play()
		get_tree().call_group("t19Particle", "emit")
		can_fire = false
		current_ammo -= 1
		print(get_current_ammo())
		check_collision(15)
		await get_tree().create_timer(fire_rate).timeout
		get_tree().call_group("t19Particle", "emitf")
		can_fire = true

