extends Node2D

var pressed = -1
var number_pressable = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Spawn")
	
	$Level1.visible = false
	$Level2.visible = false
	$Level3.visible = false
	$Level4.visible = false
	$Level5.visible = false
	$Click_Me.text = "Click Portal To Change Worlds"
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_button_up():
	
	if  get_parent().get_node("GUI_Controller").canportal:
		
		pressed *= -1
		
		if pressed == 1:
			if get_parent().get_node("Save_Controller").levels_unlocked == 1:
				$Level1.visible = true
				number_pressable = 1
			elif get_parent().get_node("Save_Controller").levels_unlocked == 2:
				$Level1.visible = true
				$Level2.visible = true
				number_pressable = 2
			elif get_parent().get_node("Save_Controller").levels_unlocked == 3:
				$Level1.visible = true
				$Level2.visible = true
				$Level3.visible = true
				number_pressable = 3
			elif get_parent().get_node("Save_Controller").levels_unlocked == 4:
				$Level1.visible = true
				$Level2.visible = true
				$Level3.visible = true
				$Level4.visible = true
				number_pressable = 4
			elif get_parent().get_node("Save_Controller").levels_unlocked == 5:
				$Level1.visible = true
				$Level2.visible = true
				$Level3.visible = true
				$Level4.visible = true
				$Level5.visible = true
				number_pressable = 5
		else:
			number_pressable = 0
			$Level1.visible = false
			$Level2.visible = false
			$Level3.visible = false
			$Level4.visible = false
			$Level5.visible = false


func _on_Level1_button_up():
	if number_pressable > 0:
		get_tree().paused = false
		var success  = get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
		if success:
			print("ABLE TO CHNAGE SCENES")


func _on_Level2_button_up():
	if number_pressable > 1:
		get_tree().paused = false
		var success = get_tree().change_scene("res://Scenes/Levels/Level2.tscn")
		if success:
			print("ABLE TO CHNAGE SCENES")


func _on_Level3_button_up():
	if number_pressable > 2:
		get_tree().paused = false
		var success = get_tree().change_scene("res://Scenes/Levels/Level3.tscn")
		if success:
			print("ABLE TO CHNAGE SCENES")


func _on_Level4_button_up():
	if number_pressable > 3:
		get_tree().paused = false
		var success = get_tree().change_scene("res://Scenes/Levels/Level4.tscn")
		if success:
			print("ABLE TO CHNAGE SCENES")


func _on_Level5_button_up():
	if number_pressable > 4:
		get_tree().paused = false
		var success = get_tree().change_scene("res://Scenes/Levels/Level5.tscn")
		if success:
			print("ABLE TO CHANGE SCENES")


func _on_TextureButton_button_down():
	
	if get_parent().get_node("GUI_Controller").canportal:
		if pressed == 1:
			$AnimationPlayer.play("Clicked")
			$Click_Me.text = "Click Portal To Change Worlds"
			get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").visible = true
			get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").disabled = false
			get_parent().get_node("GUI_Controller").paused = true
			get_tree().paused = false
		else:
			$AnimationPlayer.play("Clicked")
			$Click_Me.text = "Click Portal To Resume Game"
			get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").visible = false
			get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").disabled = true
			get_parent().get_node("GUI_Controller").paused = true
			get_tree().paused = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Clicked":
		$AnimationPlayer.play("Idle")
		get_parent().get_node("GUI_Controller").paused = false
	elif anim_name == "Spawn":
		$AnimationPlayer.play("Idle")
		
