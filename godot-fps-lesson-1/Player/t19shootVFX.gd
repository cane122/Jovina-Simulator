extends GPUParticles3D

func _ready():
	one_shot = false

func emit():
	emitting = true

func emitf():
	emitting = false
