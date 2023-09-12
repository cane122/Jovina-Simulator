extends Weapon

@export var fire_range = 2000

func _ready():
	weapon = 2
	raycast.target_position = Vector3(0, 0, -fire_range)

func fire():
	if current_weapon == 2:
		$AudioStreamPlayer.play()
		print("Fired weapon")
		can_fire = false
		current_ammo -= 1
		check_collision(50)
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
