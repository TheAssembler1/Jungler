extends Area2D

export var attack_damage = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Spikes")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Spikes_area_entered(area):
	
	if area.is_in_group("Player"):
		area.get_parent().object_health -= attack_damage
	
