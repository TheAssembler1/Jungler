extends Node2D

var window_width = 1920
var window_height = 1080

var button_width = 250
var button_height = 50
var button_distance = 70

var back_button_offset = 5

var back_able = false

var title_offset = 150

var store_purchase_cost = 30

var max_jump = 600
var max_speed = 300
var max_attack = 300

var extra_speed_boost = max_speed/3
var extra_jump_boost = max_jump/3
var extra_attack_boost = max_attack/3

var coin_text_dis = 50
var coin_text_offset = 200

var shop_bar_offset = -150
var shop_bar_width = 250
var shop_bar_height = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Play.rect_size.x = button_width
	$Play.rect_size.y = button_height
	$Play.rect_position.x = window_width/2 - ($Play.rect_size.x/2)
	$Play.rect_position.y = window_height/2 - (button_distance * 2)
	
	$Shop.rect_size.x = button_width
	$Shop.rect_size.y = button_height
	$Shop.rect_position.x = window_width/2 - ($Shop.rect_size.x/2)
	$Shop.rect_position.y = window_height/2 - button_distance
	
	$Help.rect_size.x = button_width
	$Help.rect_size.y = button_height
	$Help.rect_position.x = window_width/2 - ($Help.rect_size.x/2)
	$Help.rect_position.y = window_height/2
	
	$Credits.rect_size.x = button_width
	$Credits.rect_size.y = button_height
	$Credits.rect_position.x = window_width/2 - ($Credits.rect_size.x/2)
	$Credits.rect_position.y = window_height/2 + button_distance
	
	$Exit.rect_size.x = button_width
	$Exit.rect_size.y = button_height
	$Exit.rect_position.x = window_width/2 - ($Exit.rect_size.x/2)
	$Exit.rect_position.y = window_height/2 + button_distance*2
	
	$Back.rect_size.x = button_width
	$Back.rect_size.y = button_height
	$Back.rect_position.x = back_button_offset
	$Back.rect_position.y = back_button_offset
	$Back.visible = false
	
	#fixme..put these three buttons in a more desirable location
	
	$Jump.rect_size.x = button_width
	$Jump.rect_size.y = button_height
	
	$Attack.rect_size.x = button_width
	$Attack.rect_size.y = button_height
	
	$Speed.rect_size.x = button_width
	$Speed.rect_size.y = button_height
	
	$Jump.rect_position.x = window_width/2 + shop_bar_offset - $Jump.rect_size.x/2
	$Speed.rect_position.x = window_width/2 + shop_bar_offset - $Speed.rect_size.x/2
	$Attack.rect_position.x = window_width/2 + shop_bar_offset - $Attack.rect_size.x/2
	
	$Jump.rect_position.y = (window_height/2) + button_distance
	$Speed.rect_position.y = window_height/2
	$Attack.rect_position.y = (window_height/2) - button_distance
	
	$Jump.visible = false
	$Attack.visible = false
	$Speed.visible = false
	$Jump.disabled = true
	$Attack.disabled = true
	$Speed.disabled = true
	
	$HelpTitle.rect_position.x = window_width/2 - ($HelpTitle.rect_size.x/2)
	$HelpContent.rect_position.x = window_width/2 - ($HelpContent.rect_size.x/2)
	$CreditsTitle.rect_position.x = window_width/2 - ($CreditsTitle.rect_size.x/2)
	$CreditsContent.rect_position.x = window_width/2 - ($CreditsContent.rect_size.x/2)
	$HelpTitle.rect_position.y = title_offset
	$HelpContent.rect_position.y = $HelpTitle.rect_position.y + title_offset
	$CreditsTitle.rect_position.y = title_offset
	$CreditsContent.rect_position.y = $CreditsTitle.rect_position.y + title_offset
	$HelpTitle.visible = false
	$HelpContent.visible = false
	$CreditsTitle.visible = false
	$CreditsContent.visible = false
	
	$Coins_Acquired.text = "YOU HAVE "+String(get_node("Save_Controller").coins)+" COINS"
	$Coins_Required.text = "PURCHASE REQUIRES "+String(store_purchase_cost)+" COINS"
	
	$Coins_Acquired.rect_position.x = window_width/2 - ($Coins_Acquired.rect_size.x/2)
	$Coins_Required.rect_position.x = window_width/2 - ($Coins_Required.rect_size.x/2)
	
	$Coins_Acquired.rect_position.y = coin_text_offset
	$Coins_Required.rect_position.y = $Coins_Acquired.rect_position.y + coin_text_dis
	
	$Coins_Acquired.visible = false
	$Coins_Required.visible = false
	
	$SpeedBar.rect_size.x = shop_bar_width
	$AttackBar.rect_size.x = shop_bar_width
	$JumpBar.rect_size.x = shop_bar_width
	
	$SpeedBar.rect_size.y = shop_bar_height
	$AttackBar.rect_size.y = shop_bar_height
	$JumpBar.rect_size.y = shop_bar_height
	
	$SpeedBar.rect_position.x = (window_width/2) - shop_bar_offset - $SpeedBar.rect_size.x/2
	$AttackBar.rect_position.x = (window_width/2) - shop_bar_offset - $AttackBar.rect_size.x/2
	$JumpBar.rect_position.x = (window_width/2) - shop_bar_offset - $JumpBar.rect_size.x/2
	
	$SpeedBar.rect_position.y = $Speed.rect_position.y
	$AttackBar.rect_position.y = $Attack.rect_position.y
	$JumpBar.rect_position.y = $Jump.rect_position.y
	
	$SpeedBar.visible = false
	$AttackBar.visible = false
	$JumpBar.visible = false
	
	$SpeedBar.max_value = max_speed
	$JumpBar.max_value = max_jump
	$AttackBar.max_value = max_attack
	

func _on_Play_button_up():
	if !back_able:
		if $Save_Controller.current_level == 1:
			var success = get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
			if success == 0:
				print("ABLE TO CHANGE SCENES")
		elif $Save_Controller.current_level == 2:
			var success = get_tree().change_scene("res://Scenes/Levels/Level2.tscn")
			if success:
				print("ABLE TO CHANGE SCENES")
		elif $Save_Controller.current_level == 3:
			var success = get_tree().change_scene("res://Scenes/Levels/Level3.tscn")
			if success:
				print("ABLE TO CHANGE SCENES")
		elif $Save_Controller.current_level == 4:
			var success = get_tree().change_scene("res://Scenes/Levels/Level4.tscn")
			if success:
				print("ABLE TO CHANGE SCENES")
		elif $Save_Controller.current_level == 5:
			var success = get_tree().change_scene("res://Scenes/Levels/Level5.tscn")
			if success:
				print("ABLE TO CHANGE SCENES")
		elif $Save_Controller.current_level == 6:
			var success = get_tree().change_scene("res://Scenes/Levels/Level6.tscn")
			if success:
				print("ABLE TO CHANGE SCENES")
		elif $Save_Controller.current_level == 7:
			var success = get_tree().change_scene("res://Scenes/Levels/Level7.tscn")
			if success:
				print("ABLE TO CHANGE SCENES")
		elif $Save_Controller.current_level == 8:
			var success = get_tree().change_scene("res://Scenes/Levels/Level8.tscn")
			if success:
				print("ABLE TO CHANGE SCENES")
		elif $Save_Controller.current_level == 9:
			var success = get_tree().change_scene("res://Scenes/Levels/Level9.tscn")
			if success:
				print("ABLE TO CHANGE SCENES")


func _on_Help_button_up():
	if !back_able:
		back_able = true
		$Play.visible = false
		$Help.visible = false
		$Exit.visible = false
		$Credits.visible = false
		$Shop.visible = false
		$Back.visible = true
		$HelpTitle.visible = true
		$HelpContent.visible = true

func _on_Credits_button_up():
	if !back_able:
		back_able = true
		$Play.visible = false
		$Help.visible = false
		$Exit.visible = false
		$Credits.visible = false
		$Shop.visible = false
		$Back.visible = true
		$CreditsTitle.visible = true
		$CreditsContent.visible = true


func _on_Exit_button_up():
	if !back_able:
		get_tree().quit()


func _on_Back_button_up():
	if back_able:
		back_able = false
		$Play.visible = true
		$Help.visible = true
		$Exit.visible = true
		$Credits.visible = true
		$Shop.visible = true
		$Back.visible = false
		$HelpTitle.visible = false
		$HelpContent.visible = false
		$CreditsTitle.visible = false
		$CreditsContent.visible = false
		$Speed.visible = false
		$Attack.visible = false
		$Jump.visible = false
		$Jump.disabled = true
		$Attack.disabled = true
		$Speed.disabled = true
		$Coins_Acquired.visible = false
		$Coins_Required.visible = false
		$SpeedBar.visible = false
		$AttackBar.visible = false
		$JumpBar.visible = false


func _on_Shop_button_up():
	if !back_able:
		back_able = true
		$Play.visible = false
		$Help.visible = false
		$Exit.visible = false
		$Credits.visible = false
		$Shop.visible = false
		$Back.visible = true
		$Attack.visible = true
		$Jump.visible = true
		$Speed.visible = true
		$Attack.disabled = false
		$Jump.disabled = false
		$Speed.disabled = false
		$Coins_Acquired.visible = true
		$Coins_Required.visible = true
		$SpeedBar.visible = true
		$AttackBar.visible = true
		$JumpBar.visible = true
		$SpeedBar.value = get_node("Save_Controller").extra_speed
		$JumpBar.value = get_node("Save_Controller").extra_jump_power
		$AttackBar.value = get_node("Save_Controller").extra_attack_power


func _on_Speed_button_up():
	if get_node("Save_Controller").extra_speed < max_speed && get_node("Save_Controller").coins >= store_purchase_cost:
		get_node("Save_Controller").coins -= store_purchase_cost
		get_node("Save_Controller").extra_speed += extra_speed_boost
		get_node("Save_Controller").call("save_game")
		$Coins_Acquired.text = "YOU HAVE "+String(get_node("Save_Controller").coins)+" COINS"
		$Coins_Required.text = "PURCHASE REQUIRES "+String(store_purchase_cost)+" COINS"
		$SpeedBar.value = get_node("Save_Controller").extra_speed
	else:
		print("NOT ENOUGHT MONEY. COINS = "+String(get_node("Save_Controller").coins))
		print("COINS NEEDED = "+String(store_purchase_cost))


func _on_Jump_button_up():
	if get_node("Save_Controller").extra_jump_power < max_jump && get_node("Save_Controller").coins >= store_purchase_cost:
		get_node("Save_Controller").coins -= store_purchase_cost
		get_node("Save_Controller").extra_jump_power += extra_jump_boost
		get_node("Save_Controller").call("save_game")
		$Coins_Acquired.text = "YOU HAVE "+String(get_node("Save_Controller").coins)+" COINS"
		$Coins_Required.text = "PURCHASE REQUIRES "+String(store_purchase_cost)+" COINS"
		$JumpBar.value = get_node("Save_Controller").extra_jump_power
	else:
		print("NOT ENOUGHT MONEY. COINS = "+String(get_node("Save_Controller").coins))
		print("COINS NEEDED = "+String(store_purchase_cost))


func _on_Attack_button_up():
	if get_node("Save_Controller").extra_attack_power < max_attack && get_node("Save_Controller").coins >= store_purchase_cost:
		get_node("Save_Controller").coins -= store_purchase_cost
		get_node("Save_Controller").extra_attack_power += extra_attack_boost
		get_node("Save_Controller").call("save_game")
		$Coins_Acquired.text = "YOU HAVE "+String(get_node("Save_Controller").coins)+" COINS"
		$Coins_Required.text = "PURCHASE REQUIRES "+String(store_purchase_cost)+" COINS"
		$AttackBar.value = get_node("Save_Controller").extra_attack_power
	else:
		print("NOT ENOUGHT MONEY. COINS = "+String(get_node("Save_Controller").coins))
		print("COINS NEEDED = "+String(store_purchase_cost))
