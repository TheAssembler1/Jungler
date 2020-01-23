extends Node2D

export var button_width = 350
export var button_height = 50
export var button_distance_y = 70
export var button_distance_x = 200

export var title_offset_y = 200

export var question_offset_x = 1920/2
export var question_offset_y = 1080/2

export var question_damage = 100

var question_answer = ""

var played = false

var questions =["Who serves as the Executive Assistant to the president for FBLA?", \
				"1", \
				"3", \
				"Aric Mills", \
				"Richard Bowen", \
				"Elena R. Daly", \
				"Robert Smothers", \
				\
				"Who is the Director of Marketing and Membership?", \
				"1", \
				"1", \
				"Troy D. White", \
				"Mary Ait", \
				"Ron Pierce", \
				"Ryan Paul", \
				\
				"What is the national theme for FBLA for 2018-2019?", \
				"1", \
				"2", \
				"Go Big or Go Home", \
				"Create, Lead, Inspire", \
				"Jazzin'Up Leadership", \
				"Initiate, Follow, Influence", \
				\
				"Which state is the FBLA National Center located at?", \
				"1", \
				"3", \
				"Kansas", \
				"Texas", \
				"Virginia", \
				"California", \
				\
				"Which one of these states is NOT one of the 2018 National Fall Leadership sites?", \
				"1", \
				"4", \
				"Illinois", \
				"New Mexico", \
				"North Carolina", \
				"Arizona", \
				\
				"Who serves as the Conference Manager for FBLA?", \
				"1", \
				"2", \
				"Glenn Morris", \
				"Robert Smothers", \
				"Corbin Robinson", \
				"Lisa Smothers", \
				\
				"Where was the 2018 FBLA National Conference be held? ", \
				"1", \
				"1", \
				"Baltimore, Maryland", \
				"Chicago, Illinois", \
				"Washington D.C", \
				"Los Angeles, California", \
				\
				"Where will the 2019 FBLA National Conference be held?", \
				"1", \
				"2", \
				"New York City, New York", \
				"San Antonio, Texas", \
				"St. Louis, Missouri", \
				"Indianapolis, Indiana", \
				\
				"What month was the 2019 FBLA National Conference held?", \
				"1", \
				"2", \
				"May", \
				"June", \
				"July", \
				"August", \
				\
				"Who is the Director of College & University Relations?", \
				"1", \
				"3", \
				"Stacee Y. Mclff", \
				"Becky Grant", \
				"Tom Payne", \
				"Ron Pierce", \
				\
				"Who is the National FBLA President?", \
				"1", \
				"3", \
				"Keerti Soundappan", \
				"Michael Zhao", \
				"Eu Ro Wang", \
				"Donald Trump", \
				\
				"Who is the National Secretary of FBLA?", \
				"1", \
				"1", \
				"Keerti Soundappan", \
				"Timothy Simmons", \
				"Ty Richard", \
				"Eli Amyx", \
				\
				"Who is the National Treasurer of FBLA?", \
				"1", \
				"4", \
				"Davis Ellis", \
				"Garrett Koch", \
				"Trentyn Tennant", \
				"Galadriel Coury", \
				\
				"Who is the National Parliamentarian of FBLA?", \
				"1", \
				"2", \
				"Colton Tilley", \
				"Michael Zhao", \
				"David Ker", \
				"Madelyn Remington", \
				\
				"Who is the National Vice President of FBLA in the Eastern Region?", \
				"1", \
				"1", \
				"Garret Koch", \
				"Madelyn Remington", \
				"Bram Saracino", \
				"Michael Zhao", \
				\
				"Who is the National Vice President of FBLA in the Southern Region?", \
				"1", \
				"4", \
				"Eli Amyx", \
				"Katherine Nevils", \
				"Eu Ro Wang", \
				"Ty Rickard", \
				\
				"Who is the National Vice President of FBLA in the North Central Region?", \
				"1", \
				"2", \
				"Keerti Soundappan", \
				"Eli Amyx", \
				"Cason Oglesby", \
				"Galadriel Coury", \
				\
				"Who is the National Vice President of FBLA in the Mountain Plains Region?", \
				"1", \
				"3", \
				"Trentyn Tennant", \
				"Chirstan Bates", \
				"Madelyn Remington", \
				"Michael Zhao", \
				\
				"Who is the National Vice President of FBLA in the Western Region?", \
				"1", \
				"1", \
				"Trentyn Tennant", \
				"Eli Amyx", \
				"Clint Parr", \
				"Eu Ro Wang", \
				\
				"Which National FBLA Officer appoints the FBLA National Parliamentarian?", \
				"1", \
				"1", \
				"President", \
				"Secretary", \
				"Treasurer", \
				"VP-Easter Region", \
				\
				"What year was the possecondary division, Phi Beta Lamda, created?", \
				"1", \
				"4", \
				"1958", \
				"1783", \
				"2018", \
				"1952", \
				\
				"Is the FBLA-PBL National Center mortgage Retired?", \
				"2", \
				"1", \
				"true", \
				"false", \
				"", \
				"", \
				\
				"What year was the grand opening of the 11,600 square foot FBLA-PBL National Center is held?", \
				"1", \
				"1", \
				"1991", \
				"1860", \
				"2016", \
				"300", \
				\
				"Did the board of directors approve the establishment of the FBLA-PBL Alumni division?", \
				"2", \
				"1", \
				"true", \
				"false", \
				"", \
				"", \
				\
				"Edward D. Miller is not the full-time executive director.", \
				"2", \
				"2", \
				"true", \
				"false", \
				"", \
				"", \
				\
				"When was the concept of FBLA conceived?", \
				"1", \
				"1", \
				"1937", \
				"1892", \
				"1230", \
				"3028", \
				\
				"Who is the customer service/database associate?", \
				"1", \
				"1", \
				"Ashely Witherspoon", \
				"Daneil Spoon", \
				"Webster Spoon", \
				"Joshua Spoony", \
				\
				"Brenda Merkel is the PBL adviser presentation college of the Mountain plains regions.", \
				"2", \
				"1", \
				"true", \
				"false", \
				"", \
				"", \
				\
				"Who is the Membership Director of FBLA?", \
				"1", \
				"1", \
				"Lisa Smothers", \
				"Noah Lewis", \
				"Danielle Radcliffe", \
				"John Smith", \
				\
				"Does FLBA have an instagram?", \
				"2", \
				"1", \
				"true", \
				"false", \
				"", \
				"", \
				\
				"How many high school members does FBLA have?", \
				"1", \
				"3", \
				"115,000", \
				"200,000", \
				"215,000", \
				"300,000", \
				\
				"How long does the FBLA-PBL Board of Directors chairmen serve in that office?", \
				"1", \
				"1", \
				"1 year", \
				"2 years", \
				"3 years", \
				"4 years", \
				\
				"How many districts are in Louisiana?", \
				"1", \
				"3", \
				"4", \
				"3", \
				"6", \
				"10", \
				\
				"How long does the FBLA-PBL board of directors charimen serve in that office?", \
				"1", \
				"3", \
				"three years", \
				"two years", \
				"one year", \
				"four years", \
				\
				"What year did FBLA gain independent status?", \
				"1", \
				"1", \
				"1969", \
				"1970", \
				"1971", \
				"1972", \
				\
				"What is American Enterprise Day observed each year?", \
				"1", \
				"2", \
				"November. 1", \
				"Novemeber 15", \
				"October 3", \
				"August 4", \
				\
				"What does NAP stand for?", \
				"1", \
				"1", \
				"Nation Awards Program", \
				"Naps Are Present", \
				"Nothing And Parts", \
				"Now And Present", \
				\
				"Excluding the 3 division presidents, what is the term of office for the National Board of Directors Members?", \
				"1", \
				"3", \
				"9 years", \
				"5 years", \
				"3 years", \
				"10 years", \
				\
				"How much does it cost to become a lifetime member of the professional division?", \
				"1", \
				"4", \
				"200 dollars", \
				"300 dollars", \
				"400 dollars", \
				"350 dollars", \
				\
				"Is FBLA primarily funded by Memebership Dues?", \
				"2", \
				"1", \
				"true", \
				"false", \
				"", \
				"", \
				\
				"What is another term for a written plan of action?", \
				"1", \
				"4", \
				"A contract", \
				"Progress", \
				"Getting down to bussiness", \
				"Program of work", \
				\
				"What state became FBLA's first state Chapter?", \
				"1", \
				"1", \
				"Iowa", \
				"Canada", \
				"Louisiana", \
				"Texas", \
				\
				"What catagory is Business Plan in?", \
				"1", \
				"4", \
				"Planning", \
				"Business Plan", \
				"Bussiness Organization", \
				"Individual/Team", \
				\
				"Who is considered the father of Louisiana FBLA?", \
				"1", \
				"1", \
				"Richard D. Clanton", \
				"Quincy Richard", \
				"Cameron Walters", \
				"Adom Sanders", \
				\
				"According to the FBLA-PBL format guide, the top margin on  a memorandum should be?", \
				"1", \
				"3", \
				"7 inches", \
				"3 inches", \
				"2 inches", \
				"10 inches", \
				\
				"How many members must you recruit to be recognized for membership madness?", \
				"1", \
				"1", \
				"5", \
				"6", \
				"1", \
				"35", \
				\
				"How many members must you recruit to be recognized for Membership Mania?", \
				"1", \
				"4", \
				"13", \
				"12", \
				"79", \
				"10", \
				\
				"Is Tommorow's Business Leader the name of the publication for FBLA High School and Middle School?", \
				"2", \
				"1", \
				"true", \
				"false", \
				"", \
				"", \
				\
				"What two words are repeated throughout the FBLA-PBL creed?", \
				"1", \
				"3", \
				"Work Hard", \
				"Hard Work", \
				"I Believe", \
				"Business Greatness", \
				\
				"NBEA stands for National busness Education Associates", \
				"2", \
				"2", \
				"true", \
				"false", \
				"", \
				""]
				
func _ready():
	$CanvasLayer.get_node("Question").visible = false
	$CanvasLayer.get_node("A").visible = false
	$CanvasLayer.get_node("B").visible = false
	$CanvasLayer.get_node("C").visible = false
	$CanvasLayer.get_node("D").visible = false
	$CanvasLayer.get_node("A").disabled = true
	$CanvasLayer.get_node("B").disabled = true
	$CanvasLayer.get_node("C").disabled = true
	$CanvasLayer.get_node("D").disabled = true
	
	$CanvasLayer.get_node("A").rect_size.x = button_width
	$CanvasLayer.get_node("B").rect_size.x = button_width
	$CanvasLayer.get_node("C").rect_size.x = button_width
	$CanvasLayer.get_node("D").rect_size.x = button_width
	$CanvasLayer.get_node("A").rect_size.y = button_height
	$CanvasLayer.get_node("B").rect_size.y = button_height
	$CanvasLayer.get_node("C").rect_size.y = button_height
	$CanvasLayer.get_node("D").rect_size.y = button_height



func _on_Area2D_area_entered(area):
	if area.is_in_group("Player") && !played:
		get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").visible = false 
		get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").disabled = true
		played = true
		print("QUESTION HIT PLAYER")
		get_tree().paused = true
		
		#FIXME DISABLE PAUSE BUTTON DURING QUESION SEQUENCE
		randomize()
		var random_number = randi()%50+0
		var question = random_number
		
		question *= 7

		print("RANDOM NUMBER IS " + String(random_number))
		print("QUESTION IS NUMBER " + String(question))
		print("ARRAY SHOWS " + String(questions[question]))
		
		$CanvasLayer.get_node("A").disabled = false
		$CanvasLayer.get_node("B").disabled = false
		$CanvasLayer.get_node("C").disabled = false
		$CanvasLayer.get_node("D").disabled = false
		
		if questions[question+1] == "1":
			print("MULTI QUESTION")
			question_answer = questions[question+2]
			multi_question(question)
		else:
			print("BOOL QUESTION")
			question_answer = questions[question+2]
			bool_question(question)



func bool_question(var question):
	
	$CanvasLayer.get_node("Question").visible = true
	$CanvasLayer.get_node("A").visible = true
	$CanvasLayer.get_node("B").visible = true
	
	$CanvasLayer.get_node("Question").text = questions[question]
	$CanvasLayer.get_node("A").text = questions[question+3]
	$CanvasLayer.get_node("B").text = questions[question+4]
	
	$CanvasLayer.get_node("Question").rect_position.x = (question_offset_x) - ($CanvasLayer.get_node("Question").rect_size.x/2)
	$CanvasLayer.get_node("A").rect_position.x = (question_offset_x) - ($CanvasLayer.get_node("A").rect_size.x/2) - button_distance_x
	$CanvasLayer.get_node("B").rect_position.x = (question_offset_x) - ($CanvasLayer.get_node("B").rect_size.x/2) + button_distance_x
	
	$CanvasLayer.get_node("Question").rect_position.y = title_offset_y
	
	$CanvasLayer.get_node("A").rect_position.y = (question_offset_y)
	$CanvasLayer.get_node("B").rect_position.y = (question_offset_y)


func multi_question(var question):
	
	$CanvasLayer.get_node("Question").visible = true
	$CanvasLayer.get_node("A").visible = true
	$CanvasLayer.get_node("B").visible = true
	$CanvasLayer.get_node("C").visible = true
	$CanvasLayer.get_node("D").visible = true
	
	$CanvasLayer.get_node("Question").text = questions[question]
	$CanvasLayer.get_node("A").text = questions[question+3]
	$CanvasLayer.get_node("B").text = questions[question+4]
	$CanvasLayer.get_node("C").text = questions[question + 5]
	$CanvasLayer.get_node("D").text = questions[question + 6]
	
	$CanvasLayer.get_node("Question").rect_position.x = (question_offset_x) - ($CanvasLayer.get_node("Question").rect_size.x/2)
	$CanvasLayer.get_node("A").rect_position.x = (question_offset_x) - ($CanvasLayer.get_node("A").rect_size.x/2) - button_distance_x
	$CanvasLayer.get_node("B").rect_position.x = (question_offset_x) - ($CanvasLayer.get_node("B").rect_size.x/2) - button_distance_x
	$CanvasLayer.get_node("C").rect_position.x = (question_offset_x) - ($CanvasLayer.get_node("C").rect_size.x/2) + button_distance_x
	$CanvasLayer.get_node("D").rect_position.x = (question_offset_x) - ($CanvasLayer.get_node("D").rect_size.x/2) + button_distance_x
	
	$CanvasLayer.get_node("A").rect_position.y = (question_offset_y) + button_distance_y
	$CanvasLayer.get_node("B").rect_position.y = (question_offset_y) - button_distance_y
	$CanvasLayer.get_node("C").rect_position.y = (question_offset_y) + button_distance_y
	$CanvasLayer.get_node("D").rect_position.y = (question_offset_y) - button_distance_y
	
	$CanvasLayer.get_node("Question").rect_position.y = title_offset_y

func _on_A_button_up():
	print("CLICKED A BUTTON")
	print("QUESTION ANSWER = "+String(question_answer))
	if question_answer != "1":
		get_parent().get_node("Player").object_health -= question_damage
	else:
		get_parent().get_node("Save_Controller").coins += 50
	$CanvasLayer.get_node("Question").visible = false
	$CanvasLayer.get_node("A").visible = false
	$CanvasLayer.get_node("B").visible = false
	$CanvasLayer.get_node("C").visible = false
	$CanvasLayer.get_node("D").visible = false
	$CanvasLayer.get_node("A").disabled = true
	$CanvasLayer.get_node("B").disabled = true
	$CanvasLayer.get_node("C").disabled = true
	$CanvasLayer.get_node("D").disabled = true
	get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").disabled = false
	get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").visible = true
	get_tree().paused = false


func _on_B_button_up():
	print("CLICKED B BUTTON")
	print("QUESTION ANSWER = "+String(question_answer))
	if question_answer != "2":
		get_parent().get_node("Player").object_health -= question_damage
	else:
		get_parent().get_node("Save_Controller").coins += 50
	$CanvasLayer.get_node("Question").visible = false
	$CanvasLayer.get_node("A").visible = false
	$CanvasLayer.get_node("B").visible = false
	$CanvasLayer.get_node("C").visible = false
	$CanvasLayer.get_node("D").visible = false
	$CanvasLayer.get_node("A").disabled = true
	$CanvasLayer.get_node("B").disabled = true
	$CanvasLayer.get_node("C").disabled = true
	$CanvasLayer.get_node("D").disabled = true
	get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").disabled = false
	get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").visible = true
	get_tree().paused = false


func _on_C_button_up():
	print("CLICKED C BUTTON")
	print("QUESTION ANSWER = "+String(question_answer))
	if question_answer != "3":
		get_parent().get_node("Player").object_health -= question_damage
	else:
		get_parent().get_node("Save_Controller").coins += 50
	$CanvasLayer.get_node("Question").visible = false
	$CanvasLayer.get_node("A").visible = false
	$CanvasLayer.get_node("B").visible = false
	$CanvasLayer.get_node("C").visible = false
	$CanvasLayer.get_node("D").visible = false
	$CanvasLayer.get_node("A").disabled = true
	$CanvasLayer.get_node("B").disabled = true
	$CanvasLayer.get_node("C").disabled = true
	$CanvasLayer.get_node("D").disabled = true
	get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").disabled = false
	get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").visible = true
	get_tree().paused = false


func _on_D_button_up():
	print("CLICKED D BUTTON")
	print("QUESTION ANSWER = "+String(question_answer))
	if question_answer != "4":
		get_parent().get_node("Player").object_health -= question_damage
	else:
		get_parent().get_node("Save_Controller").coins += 50
	$CanvasLayer.get_node("Question").visible = false
	$CanvasLayer.get_node("A").visible = false
	$CanvasLayer.get_node("B").visible = false
	$CanvasLayer.get_node("C").visible = false
	$CanvasLayer.get_node("D").visible = false
	$CanvasLayer.get_node("A").disabled = true
	$CanvasLayer.get_node("B").disabled = true
	$CanvasLayer.get_node("C").disabled = true
	$CanvasLayer.get_node("D").disabled = true
	get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").disabled = false
	get_parent().get_node("GUI_Controller").get_node("CanvasLayer").get_node("Pause").visible = true
	get_tree().paused = false
