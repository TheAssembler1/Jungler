extends KinematicBody2D

#normal variables
export var gravity = 8
export var skeleton_speed = 70
export var attack_damage = 200
export var object_health = 500
var motion = Vector2()
var normal_floor = Vector2()

export var chasing_distance = 200
export var hitting_distance = 10
export var coin_value = 5

var cliff = false

#particle effect
onready var death_animation_resource = preload("res://Scenes/ParticleEffects/LilSkeletonParticles.tscn")

onready var death_animation = death_animation_resource.instance()

var left_player_side = -60
var right_player_side = 60

#variables attaches to the player
onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#adding node to lilskeleton group
	$Area2D.add_to_group("LilSkeleton")

#called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if delta < 0:
		print("IMPROBABLE DELTA")
	#checking if we are dead
	if object_health <= 0:
		get_parent().get_node("Save_Controller").coins += coin_value 
		print("Killing LilSkeleton")
		#setting up and adding particle effect animation
		death_animation.position.x = position.x
		death_animation.position.y = position.y
		get_parent().add_child(death_animation)
		queue_free()
	
	#follows the player and does movement
	Follow_Player()

#follows the player and does movement
func Follow_Player():
	
	#applies gravity
	motion.y += gravity
	
	if position.x < player.position.x:
		$Cliff.position.x = right_player_side
	elif position.x > player.position.x:
		$Cliff.position.x = left_player_side
	
	if $Cliff.is_colliding():
		cliff = false
		if position.x < player.position.x:
			$AnimatedSprite.flip_h = false
			motion.x = skeleton_speed
		elif position.x > player.position.x:
			$AnimatedSprite.flip_h = true
			motion.x = -skeleton_speed
	else:
		cliff = true
		motion.x = 0
	
	
	
	var distance = player.position.x - position.x
	
	if distance < 0:
		distance *= -1
		
	if distance > chasing_distance || distance < hitting_distance || cliff:
		$AnimatedSprite.animation = "Idle"
		motion.x = 0
	else:
		$AnimatedSprite.animation = "Running"
	
	#actually moves the player
	motion = move_and_slide(motion, normal_floor)

func _on_Area2D_area_entered(area):
	
	#checking if we collide with player
	if area.is_in_group("Player"):
		
		#giving damage to the player
		area.get_parent().object_health -= attack_damage


func _on_Swing_area_entered(area):
	pass # Replace with function body.
