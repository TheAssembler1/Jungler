extends Node2D

var window_width = 1920
var window_height = 1080

var button_width = 250
var button_height = 50

var button_distance = 70

export var paused  = false
export var canportal = false

var mod = 0
export var mod_speed = .007
export var game_over_up = 200

export var button_gameover_distance = 150
var game_over_y = window_height/2 - 50

export var fps_coins_x = 1750

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$CanvasLayer.get_node("Resume").rect_size.x = button_width
	$CanvasLayer.get_node("Resume").rect_size.y = button_height
	$CanvasLayer.get_node("Resume").rect_position.x = window_width/2 - ($CanvasLayer.get_node("Resume").rect_size.x/2)
	$CanvasLayer.get_node("Resume").rect_position.y = window_height/2 - button_distance*2
	
	$CanvasLayer.get_node("Main_Menu").rect_size.x = button_width
	$CanvasLayer.get_node("Main_Menu").rect_size.y = button_height
	$CanvasLayer.get_node("Main_Menu").rect_position.x = window_width/2 - ($CanvasLayer.get_node("Main_Menu").rect_size.x/2)
	$CanvasLayer.get_node("Main_Menu").rect_position.y = window_height/2 - button_distance
	
	$CanvasLayer.get_node("Save").rect_size.x = button_width
	$CanvasLayer.get_node("Save").rect_size.y = button_height
	$CanvasLayer.get_node("Save").rect_position.x = window_width/2 - ($CanvasLayer.get_node("Save").rect_size.x/2)
	$CanvasLayer.get_node("Save").rect_position.y = window_height/2
	
	$CanvasLayer.get_node("Exit").rect_size.x = button_width
	$CanvasLayer.get_node("Exit").rect_size.y = button_height
	$CanvasLayer.get_node("Exit").rect_position.x = window_width/2 - ($CanvasLayer.get_node("Exit").rect_size.x/2)
	$CanvasLayer.get_node("Exit").rect_position.y = window_height/2 + button_distance
	
	$CanvasLayer.get_node("Retry").rect_size.x = button_width
	$CanvasLayer.get_node("Retry").rect_size.y = button_height
	$CanvasLayer.get_node("Retry").rect_position.x = window_width/2 - ($CanvasLayer.get_node("Retry").rect_size.x/2)
	$CanvasLayer.get_node("Retry").rect_position.y = game_over_y + button_distance
	$CanvasLayer.get_node("Retry").visible = false
	
	$CanvasLayer.get_node("Exit").visible = false
	$CanvasLayer.get_node("Save").visible = false
	$CanvasLayer.get_node("Main_Menu").visible = false
	$CanvasLayer.get_node("Resume").visible = false
	
	$CanvasLayer.get_node("Game_Over").rect_position.x = window_width/2 - ($CanvasLayer.get_node("Game_Over").rect_size.x/2)
	$CanvasLayer.get_node("Game_Over").rect_position.y = window_height/2 - game_over_up
	$CanvasLayer.get_node("Game_Over").visible = false
	
	$CanvasLayer/FPSCounter.rect_position.x = fps_coins_x
	$CanvasLayer/Coins.rect_position.x = fps_coins_x



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delta < 0:
		print("IMPROBABLE DELTA")
	$CanvasLayer.get_node("FPSCounter").text = "FPS  "+str(Engine.get_frames_per_second())
	$CanvasLayer.get_node("Coins").text  = "Coins  "+str(get_parent().get_node("Save_Controller").coins)
	
	if Input.is_action_just_pressed("ui_escape"):
		if !get_parent().get_node("Player").game_over:
			get_tree().paused = true
			paused = true
			$CanvasLayer.get_node("Pause").visible = false
			$CanvasLayer.get_node("Exit").visible = true
			$CanvasLayer.get_node("Save").visible = true
			$CanvasLayer.get_node("Main_Menu").visible = true
			$CanvasLayer.get_node("Resume").visible = true
	
	if get_parent().get_node("Player").dead:
		$CanvasLayer.get_node("Pause").visible = false
	
	if get_parent().get_node("Player").game_over:
		$CanvasLayer.get_node("Game_Over").visible = true
		$CanvasLayer.get_node("Retry").visible = true
		$CanvasLayer.get_node("Main_Menu").visible = true
		$CanvasLayer.get_node("Exit").visible = true
		$CanvasLayer.get_node("Main_Menu").rect_position.y = game_over_y + button_distance
		$CanvasLayer.get_node("Exit").rect_position.y = game_over_y + button_distance
		
		$CanvasLayer.get_node("Exit").rect_position.x  = window_width/2 - button_gameover_distance - ($CanvasLayer.get_node("Retry").rect_size.x)
		$CanvasLayer.get_node("Main_Menu").rect_position.x = window_width/2 + button_gameover_distance 
		if mod < 1:
			$CanvasLayer.get_node("Game_Over").modulate = Color(mod, mod, mod)
			$CanvasLayer.get_node("Exit").modulate = Color(mod, mod, mod)
			$CanvasLayer.get_node("Retry").modulate = Color(mod, mod, mod)
			$CanvasLayer.get_node("Main_Menu").modulate = Color(mod, mod, mod)
			mod += mod_speed
			paused = true


func _on_Pause_button_up():
	if !get_parent().get_node("Player").game_over:
		canportal = false
		get_tree().paused = true
		paused = true
		$CanvasLayer.get_node("Pause").visible = false
		$CanvasLayer.get_node("Exit").visible = true
		$CanvasLayer.get_node("Save").visible = true
		$CanvasLayer.get_node("Main_Menu").visible = true
		$CanvasLayer.get_node("Resume").visible = true


func _on_Main_Menu_button_up():
	if paused:
		get_tree().paused = false
		var success = get_tree().change_scene("res://Scenes/Levels/Play_Scene.tscn")
		if success:
			print("ABLE TO CHANGE SCENES")

func _on_Exit_button_up():
	if paused:
		get_tree().paused = false
		get_tree().quit()


func _on_Resume_button_up():
	if paused:
		canportal = true
		get_tree().paused = false
		paused = false
		$CanvasLayer.get_node("Pause").visible = true
		$CanvasLayer.get_node("Exit").visible = false
		$CanvasLayer.get_node("Save").visible = false
		$CanvasLayer.get_node("Main_Menu").visible = false
		$CanvasLayer.get_node("Resume").visible = false


func _on_Save_button_up():
	get_parent().get_node("Save_Controller").call("save_game")
	pass # Replace with function body.


func _on_Pause_button_down():
	if !paused:
		paused = true

func _on_Pause_pressed():
	if !paused:
		paused = true


func _on_Retry_button_up():
	if get_parent().get_node("Player").game_over:
		var success = get_tree().reload_current_scene()
		if success:
			print("ABLE TO RELOAD SCENE")
