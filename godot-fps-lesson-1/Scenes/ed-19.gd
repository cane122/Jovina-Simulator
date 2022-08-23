extends Weapon

export var fire_range = 2000
var temp = 1
var timeout =31.909229

func _ready():
	weapon = 3
	clip_size = 255
	current_ammo = clip_size
	raycast.cast_to = Vector3(0, 0, -fire_range)

func fire():
	if current_weapon == 3:
		if Input.is_action_just_pressed("primary_fire"):
			$AudioStreamPlayer.play(temp)
		temp = $AudioStreamPlayer.get_playback_position( )
		print(temp)
		print("Fired weapon")
		can_fire = false
		current_ammo -= 1
		check_collision(0.5)
		yield(get_tree().create_timer(fire_rate), "timeout")
		if (not Input.is_action_pressed("primary_fire")) or temp>timeout or current_ammo==0:
			$AudioStreamPlayer.stop()
		if(temp == timeout):
			temp = 0;
	
		can_fire = true
		
func reload():
	$AudioStreamPlayer.stop()
	print("Reloading")
	reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	temp =0
	current_ammo = clip_size
	reloading = false
	print("Reload complete")
	if Input.is_action_pressed("primary_fire") and current_weapon == 3:
		$AudioStreamPlayer.play()
			
