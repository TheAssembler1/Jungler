extends KinematicBody2D

#variables
export var player_speed = 200
export var player_jump_power = 500
export var gravity = 12
var motion = Vector2()
var floor_normal = Vector2(0, -1)
export var object_health = 1000
export var boss_stage = false

#reg booleans
var up = false
var down = false
var left = false
var right = false
var left_mouse_click = false
var right_mouse_click = false
var grounded = false

#anim booleans
export var attacking1 = false
var attacking2 = false
var running = false
var jumping = false
var falling = false
export var dead = false

#for the game over screen
export var game_over = false

#sound booleans
var running_sound = false
var attacking1_sound = false
var attacking2_sound = false
var jumping_sound = false
var falling_sound = false
var idle_sound = false

#damage var for lilskeleton
export var lilskeleton_body_attack_damage = 500
export var lilskeleton_attacking1_damage = 3000
export var lilskeleton_attacking2_damage = 2500

#damage var for bigskeleton
export var bigskeleton_body_attack_damage = 500
export var bigskeleton_attacking1_damage = 3000
export var bigskeleton_attacking2_damage = 2500

#damage var for Minotaur
export var minotaur_body_attack_damage = 0
export var minotaur_attacking1_damage = 3000
export var minotaur_attacking2_damage = 2500

export var death_y_position = 15
var has_died = false

#called when the node enters the scene tree for the first time.
func _ready():
	#adding to playing group
	$GeneralCollision.add_to_group("Player")
	if boss_stage:
		$Camera2D.queue_free()
	pass # Replace with function body.

#called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !dead:
		#setting player health
		$ProgressBar.value = object_health
		
	
		#gets the animation and sets sounds
		Anim_Sounds()
		
		#gets the input
		Input(delta)
	
	if object_health <= 0:
		#applies gravity=
		$AnimationPlayer.play("dead")
		idle_sound = true
		$ProgressBar.visible = false
		$GeneralCollision.monitoring = false
		
		if !has_died:
			position.y += death_y_position
			has_died = true
		
		#this needs to be replaced with a death sound
		$Sounds.get_node("RunningSound").playing = false
		$Sounds.get_node("JumpingSound").playing = false
		$Sounds.get_node("Attacking1Sound").playing = false
		$Sounds.get_node("Attacking2Sound").playing = false
		$Sounds.get_node("FallingSound").playing = false
		$Sounds.get_node("IdleSound").playing = true
		dead = true
		
		


#this is where we get our input and set our animation booleans
func Input(var delta):

	if delta < 0:
		print("IMPROBABLE DELTA")
	#applies gravity
	motion.y += gravity

	#sets booleans
	up = Input.is_action_just_pressed("ui_up")
	down = Input.is_action_pressed("ui_down")
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
	left_mouse_click = Input.is_action_just_pressed("ui_left_mouse_click")
	right_mouse_click = Input.is_action_just_pressed("ui_right_mouse_click")

	#setting the ground
	grounded = is_on_floor()

	#flipping the sprite
	if left && !attacking1 && !attacking2:
		$Attacking1.scale.x  = -1
		$Attacking2.scale.x = -1
		$Sprite.flip_h = true
	elif right && !attacking1 && !attacking2:
		$Attacking1.scale.x = 1
		$Attacking2.scale.x = 1
		$Sprite.flip_h = false


	#checking if running
	if left && !attacking1 && !attacking2:
		if grounded:
			running = true
		motion.x = -(player_speed + get_parent().get_node("Save_Controller").extra_speed)
	elif right && !attacking1 && !attacking2:
		if grounded:
			running = true
		motion.x = player_speed + get_parent().get_node("Save_Controller").extra_speed
	else:
		motion.x = 0
		running = false

	#if not on grounded running is not true
	if !grounded:
		running = false

	#setting jumping to true
	if up && grounded:
		jumping = true
		motion.y -= player_jump_power + get_parent().get_node("Save_Controller").extra_jump_power

	#checks if he is falling
	if !grounded && !jumping:
		falling = true
	else:
		falling = false

	#sets attacking1 and attackign2 animation
	if left_mouse_click && grounded && !attacking2 && !get_parent().get_node("GUI_Controller").paused:
		attacking1 = true
		running = false
	elif right_mouse_click && grounded && !attacking1:
		attacking2 = true
		running = false
		
	
	#sets character to be stationary
	if attacking1 || attacking2:
		motion.y = 0
		motion.x = 0
	
	if !jumping && !attacking1 && !attacking2 && !running && !falling:
		motion.x = 0
		motion.y = 0
	
	#actually moves character
	motion = move_and_slide(motion, floor_normal)

#sets the animations and sounds
func Anim_Sounds():
	
	#setting sounds and animations
	if running:
		running_sound = true
		attacking1_sound = false
		attacking2_sound = false
		jumping_sound = false
		falling_sound = false
		idle_sound = false
		$AnimationPlayer.play("Running")
	elif attacking1:
		running_sound = false
		attacking1_sound = true
		attacking2_sound = false
		jumping_sound = false
		falling_sound = false
		idle_sound = false
		$AnimationPlayer.play("Attacking1")
	elif attacking2:
		running_sound = false
		attacking1_sound = false
		attacking2_sound = true
		jumping_sound = false
		falling_sound = false
		idle_sound = false
		$AnimationPlayer.play("Attacking2")
	elif jumping:
		running_sound = false
		attacking1_sound = false
		attacking2_sound = false
		jumping_sound = true
		falling_sound = false
		idle_sound = false
		$AnimationPlayer.play("Jumping")
	elif falling:
		running_sound = false
		attacking1_sound = false
		attacking2_sound = false
		jumping_sound = false
		falling_sound = true
		idle_sound = false
		$AnimationPlayer.play("Falling")
	else:
		running_sound = false
		attacking1_sound = false
		attacking2_sound = false
		jumping_sound = false
		falling_sound = false
		idle_sound = true
		$AnimationPlayer.play("Idle")
	
	#setting the sounds
	
	#running
	if running_sound && !$Sounds.get_node("RunningSound").playing: 
		$Sounds.get_node("RunningSound").playing = running_sound
	elif !running_sound:
		$Sounds.get_node("RunningSound").playing = false
	
	#attacking1
	if attacking1_sound && !$Sounds.get_node("Attacking1Sound").playing:
		$Sounds.get_node("Attacking1Sound").playing = attacking1_sound
	elif !attacking1_sound:
		$Sounds.get_node("Attacking1Sound").playing = attacking1_sound
	
	#attacking2
	if attacking2_sound && !$Sounds.get_node("Attacking2Sound").playing:
		$Sounds.get_node("Attacking2Sound").playing = attacking2_sound
	elif !attacking2_sound:
		$Sounds.get_node("Attacking2Sound").playing = attacking2_sound
	
	#jumping
	if jumping_sound && !$Sounds.get_node("JumpingSound").playing:
		$Sounds.get_node("JumpingSound").playing = jumping_sound
	elif !jumping_sound:
		$Sounds.get_node("JumpingSound").playing = jumping_sound
	
	#falling
	if falling_sound && !$Sounds.get_node("FallingSound").playing:
		$Sounds.get_node("FallingSound").playing = falling_sound
	elif !falling_sound:
		$Sounds.get_node("FallingSound").playing = falling_sound
	
	#idlesound
	if idle_sound && !$Sounds.get_node("IdleSound").playing:
		$Sounds.get_node("IdleSound").playing = idle_sound
	elif !idle_sound:
		$Sounds.get_node("IdleSound").playing = idle_sound

#checks witch animation have finished
func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == "Attacking1":
		attacking1 = false
	#setting attacking2
	elif anim_name == "Attacking2":
		attacking2 = false
	#setting falling to true
	elif anim_name == "Jumping":
		jumping = false
		falling = true

#checking general collisions
func _on_GeneralCollision_area_entered(area):
	#checking if lilskeleton collided with player
	if area.is_in_group("LilSkeleton"):
		
		#taking health from the lilskeleton
		area.get_parent().object_health -= lilskeleton_body_attack_damage
	elif area.is_in_group("BigSkeleton"):
		
		#taking health from the lilskeleton
		area.get_parent().object_health -= bigskeleton_body_attack_damage
	elif area.is_in_group("Minotaur"):
		
		#taking health from the lilskeleton
		area.get_parent().object_health -= minotaur_body_attack_damage


#collisions for attacking1
func _on_Attacking1_area_entered(area):
	
	#checking if we collide with player
	if area.is_in_group("LilSkeleton"):
		#giving damage to the player
		area.get_parent().object_health -= lilskeleton_attacking1_damage + get_parent().get_node("Save_Controller").extra_attack_power
	elif area.is_in_group("BigSkeleton"):
		#giving damage to the player
		area.get_parent().object_health -= bigskeleton_attacking1_damage + get_parent().get_node("Save_Controller").extra_attack_power
	elif area.is_in_group("Minotaur"):
		#giving damage to the player
		area.get_parent().object_health -= minotaur_attacking1_damage + get_parent().get_node("Save_Controller").extra_attack_power

func player_death():
	$AnimationPlayer.playback_speed = 0
	game_over = true

#collision for attacking2
func _on_Attacking2_area_entered(area):
	
	#checking if we collide with player
	if area.is_in_group("LilSkeleton"):
		#giving damage to the player
		area.get_parent().object_health -= lilskeleton_attacking2_damage
	elif area.is_in_group("BigSkeleton"):
		#giving damage to the player
		area.get_parent().object_health -= bigskeleton_attacking2_damage
	elif area.is_in_group("Minotaur"):
		#giving damage to the player
		area.get_parent().object_health -= minotaur_attacking2_damage	

