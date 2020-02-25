extends KinematicBody2D

#normal variables
export var gravity = 8
export var skeleton_speed = 70
export var attack_damage = 200
export var object_health = 2000
var motion = Vector2()
var normal_floor = Vector2()
export var deddone = false


var mod = 1
export var mod_change = .01


export var chasing_distance = 800
export var hitting_distance = 40
export var coin_value = 50

var cliff = false

var left_player_side = -60
var right_player_side = 60
export var dead = false

#variables attaches to the player
onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	#adding node to lilskeleton group
	$Attack.add_to_group("Wolf")

#called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if delta < 0:
		print("IMPROBABLE DELTA")
	
	#checking if we are dead
	if object_health <= 0:
		get_parent().get_node("Save_Controller").coins += coin_value 
		print("Killing Wolf")
		#setting up and adding particle effect animation
		$AnimationPlayer.play("Death")
		
		if deddone == true:
			queue_free()
		
		
	
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
			$Sprite.flip_h = false
			$Attack.scale.x = 1
			motion.x = skeleton_speed
		elif position.x > player.position.x:
			$Sprite.flip_h = true
			$Attack.scale.x = -1
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


func _on_Attack_area_entered(area):
	if area.is_in_group("Player"):
		#giving damage to the player
		area.get_parent().object_health -= attack_damage
