extends Node2D

#called when the node enters the scene tree for the first time.
func _ready():
	
	#starting the chest out closed
	$AnimatedSprite.animation = "Close"
	
	pass # Replace with function body.

#called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass


#opening the chest
func _on_Area2D_body_entered(body):
	
	if body.is_in_group("Player"):
		$AnimatedSprite.animation = "Open"

#closing the chest
func _on_Area2D_body_exited(body):
	
	if body.is_in_group("Player"):
		$AnimatedSprite.animation = "Close"
