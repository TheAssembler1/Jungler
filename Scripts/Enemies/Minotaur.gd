extends KinematicBody2D

#normal variables
export var gravity = 8
export var skeleton_speed = 40
export var attack_damage = 400
export var object_health = 4000
var motion = Vector2()
var normal_floor = Vector2()


var mod = 1
export var mod_change = .01


export var chasing_distance = 800
export var hitting_distance = 60
export var coin_value = 50

var cliff = false

var left_player_side = -60
var right_player_side = 60
export var dead = false

#variables attaches to the player
onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#disabling exit portal
	get_parent().get_node("Exit_Portal").get_node("TextureButton").disabled = true
	get_parent().get_node("Exit_Portal").get_node("StaticBody2D").get_node("CollisionShape2D").disabled = true
	get_parent().get_node("Exit_Portal").get_node("Sprite").visible = false
	get_parent().get_node("Exit_Portal").get_node("Click_Me").visible = false
	
	
	#adding node to lilskeleton group
	$Area2D.add_to_group("Minotaur")

#called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if delta < 0:
		print("IMPROBABLE DELTA")
	
	#checking if we are dead
	if object_health <= 0:
		get_parent().get_node("Save_Controller").coins += coin_value 
		print("Killing Minotaur")
		#setting up and adding particle effect animation
		$AnimationPlayer.play("Death")
		dead = true
		
		self.modulate = Color(mod, mod, mod)
		if mod >= 0:
			mod -= mod_change
		
		
	
	#follows the player and does movement
	Follow_Player()
	#displays the health
	$ProgressBar.value = object_health

#follows the player and does movement
func Follow_Player():
	
	#applies gravity
	motion.y += gravity
	
	if position.x < player.position.x:
		$Cliff.position.x = right_player_side
	elif position.x > player.position.x:
		$Cliff.position.x = left_player_side
	
	if $Cliff.is_colliding() && !dead:
		cliff = false
		if position.x < player.position.x:
			$Sprite.flip_h = true
			$Swing.scale.x = -1
			motion.x = skeleton_speed
		elif position.x > player.position.x:
			$Sprite.flip_h = false
			$Swing.scale.x = 1
			motion.x = -skeleton_speed
	else:
		cliff = true
		motion.x = 0
	
	
	
	var distance = player.position.x - position.x
	
	if object_health > 0:
		if distance < 0:
			distance *= -1
	
		if distance <= hitting_distance:
			$AnimationPlayer.play("Swing")	
			motion.x = 0
		elif distance > chasing_distance || distance < hitting_distance || cliff:
			$AnimationPlayer.play("Idle")
			motion.x = 0
		else:
			$AnimationPlayer.play("Moving")
	
		#actually moves the player
		motion = move_and_slide(motion, normal_floor)

func _on_Area2D_area_entered(area):
	
	#checking if we collide with player
	if area.is_in_group("Player"):
		
		#giving damage to the player
		area.get_parent().object_health -= attack_damage


func _on_Swing_area_entered(area):
	if area.is_in_group("Player"):
		
		#giving damage to the player
		area.get_parent().object_health -= attack_damage
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		get_parent().get_node("Exit_Portal").get_node("TextureButton").disabled = false
		get_parent().get_node("Exit_Portal").get_node("StaticBody2D").get_node("CollisionShape2D").disabled = false
		get_parent().get_node("Exit_Portal").get_node("Sprite").visible = true
		get_parent().get_node("Exit_Portal").get_node("Click_Me").visible = true
		queue_free()

