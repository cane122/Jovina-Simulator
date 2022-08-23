extends KinematicBody

export var speed = 100
var space_state
var target =null
var health = 100;
var velocity = Vector3.ZERO
var run_speed = 20
var gravity = 2
func _ready():
	space_state = get_world().direct_space_state





func _physics_process(delta):
	if target != null:
		
		velocity = (target.transform.origin - transform.origin).normalized() * run_speed
		velocity.y = 0
		var gravity_resistance = get_floor_normal() if is_on_floor() else Vector3.UP
		velocity -= gravity_resistance * gravity
		velocity = move_and_slide(velocity)

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
