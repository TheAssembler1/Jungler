extends Particles2D

#how long particles should exist
export var particle_life = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#setting the timer
	$Timer.wait_time = particle_life
	emitting = true
	
	pass # Replace with function body.

#destroys particle effect
func _on_Timer_timeout():
	print_debug("Destroying particle effect.")
	queue_free()
