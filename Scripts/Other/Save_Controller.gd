extends Node

export var coins = 0
export var levels_unlocked = 1
export var current_level = 1

export var extra_jump_power = 0
export var extra_speed = 0
export var extra_attack_power = 0

func _ready():
	
	check_game_readiness()
	
	load_game()
	check_level()
	save_game()

func check_game_readiness():
	var dir = Directory.new()
	if(!dir.dir_exists("user://Saves")):
		dir.open("user://")
		dir.make_dir("user://Saves")
		coins = 0
		levels_unlocked = 1
		current_level = 1
		extra_attack_power = 0
		extra_speed = 0
		extra_jump_power = 0
		save_game()


func check_level():
	if(get_tree (). get_current_scene (). get_name () == "Level1"):
		print("CURRENT LEVEL :: Level 1")
		current_level = 1
		save_game()
	elif(get_tree (). get_current_scene (). get_name () == "Level2"):
		print("CURRENT LEVEL :: Level 2")
		current_level = 2
		save_game()
	elif(get_tree (). get_current_scene (). get_name () == "Level3"):
		print("CURRENT LEVEL :: Level 3")
		current_level = 3
		save_game()
	elif(get_tree (). get_current_scene (). get_name () == "Level4"):
		print("CURRENT LEVEL :: Level 4")
		current_level = 4
		save_game()
	elif(get_tree (). get_current_scene (). get_name () == "Level5"):
		print("CURRENT LEVEL :: Level 5")
		current_level = 5
		save_game()
		
func save():
    var save_dict = {
		"coins" : coins,
		"levels_unlocked" : levels_unlocked,
		"current_level" : current_level,
		"extra_attack_power" : extra_attack_power,
		"extra_jump_power" : extra_jump_power,
		"extra_speed" : extra_speed
    }
    return save_dict
	
func save_game():
	var save_game = File.new()
	save_game.open("user://Saves/SAVE.sve", File.WRITE)
	var node_data = save()
	save_game.store_line(to_json(node_data))
	print("___________________________________")
	print("COINS = "+String(coins))
	print("LEVELS_UNLOCKED = "+String(levels_unlocked))
	print("CURRENT_LEVEL = "+String(current_level))
	print("EXTRA_JUMP_POWER = "+String(extra_jump_power))
	print("EXTRA_SPEED = "+String(extra_speed))
	print("EXTRA_ATTACK_POWER = "+String(extra_attack_power))
	print("___________________________________")
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://Saves/SAVE.sve"):
		return # Error! We don't have a save to load.
	save_game.open("user://Saves/SAVE.sve", File.READ)
	var current_line = {}
	current_line = parse_json(save_game.get_line())
	for i in current_line.keys():
		set(i, current_line[i])
	save_game.close()