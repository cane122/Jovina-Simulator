extends CharacterBody3D

@export var speed = 100
var space_state
var target =null
var health = 100;
var velocity1 = Vector3.ZERO
var run_speed = 20
var gravity = 2
func _ready():
	space_state = get_world_3d().direct_space_state





func _physics_process(delta):
	if target != null:
		
		velocity1 = (target.transform.origin - transform.origin).normalized() * run_speed
		velocity1.y = 0
		var gravity_resistance = get_floor_normal() if is_on_floor() else Vector3.UP
		velocity1 -= gravity_resistance * gravity
		set_velocity(velocity1)
		move_and_slide()
		velocity1 = velocity1

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$AudioStreamPlayer3D.play()
		target = body
		print(body.name + " entered")


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		print(body.name + " exited")


func takeDamage(damage):
	health -= damage
	if health<=0:
		queue_free()

func _on_AreaDmg_body_entered(body):
	if body.is_in_group("Player"):
		body.takeDamage(34)
		print(body.name + " exited")
