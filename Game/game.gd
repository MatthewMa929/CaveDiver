extends Node

@onready var title = $Background/TextContainers/TextPanels/TitleMargin/TitlePanel/TitleText
@onready var body = $Background/TextContainers/TextPanels/BodyPanel/BodyMargin/BodyText
@onready var text_timer = $TextTimer
@onready var dot_timer = $DotTimer
@onready var talk_timer = $TalkTimer
@onready var story = $Story
@onready var map = $Map
@onready var cave_view = $Map/SubViewportContainer/CaveView
@onready var code = $Code
@onready var button = $ChoiceMargin/ChoiceButtons/ChoiceButton
@onready var button2 = $ChoiceMargin/ChoiceButtons/ChoiceButton2
@onready var number_map = $Background/PictureContainers/PicturePanels/MapPanel/NumberMap
@onready var curr = story

@onready var ore = $Background/PictureContainers/PicturePanels/PhotoPanel/Ore
@onready var face = $Background/PictureContainers/PicturePanels/PhotoPanel/Face
@onready var crack = $Background/PictureContainers/PicturePanels/PhotoPanel/Crack
@onready var equipment = $Background/PictureContainers/PicturePanels/PhotoPanel/Equipment
@onready var wall = $Background/PictureContainers/PicturePanels/PhotoPanel/Wall
@onready var secret = $Background/PictureContainers/PicturePanels/PhotoPanel/Secret
@onready var cave_enter = $Background/PictureContainers/PicturePanels/PhotoPanel/CaveEnter
@onready var pic_lst = []

var char_index = 0
var path_arr = [0]
var bb_num = 0
var talking = false
var pic_vis = 0
var ore_count = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	title.text = "[center]Communications Room[/center]"
	body.text = curr.text
	body.visible_characters = char_index

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Action"):
		char_index = body.text.length()
	if Input.is_action_just_pressed("Next Picture"):
		pic_vis += 1
		if pic_vis >= pic_lst.size():
			pic_vis = 0
	for pic in pic_lst:
		pic.visible = false
	if pic_lst.size() != 0:
		pic_lst[pic_vis].visible = true
	number_map.text = " " + str(cave_view.map_vis + 1)
	
	if cave_view.hit_wall and "DeadEnd" not in path_arr:
		newCurr("Story/DeadEnd")
		cave_view.hit_wall = false
	if cave_view.curr.Event == "caved" and cave_view.near == cave_view.curr and "Rocks" not in path_arr:
		newCurr("Story/Rocks")
	if cave_view.curr.Event == "face" and cave_view.near == cave_view.curr and "Face" not in path_arr:
		newCurr("Story/Face")
	if cave_view.curr.Event == "equipment" and cave_view.near == cave_view.curr and "Equipment" not in path_arr:
		newCurr("Story/Equipment")
	if (cave_view.curr.Event == "caved" and cave_view.near == cave_view.curr and "Done" in path_arr) and "CaveIn" not in path_arr:
		newCurr("Story/CaveIn")
	if cave_view.curr.Event == "crack" and cave_view.near == cave_view.curr and "Crack" not in path_arr:
		newCurr("Story/Crack")
	if cave_view.curr.Event == "crack" and cave_view.near == cave_view.curr and "CaveIn" in path_arr and "ReachEnd" not in path_arr:
		newCurr("Story/ReachEnd")
	if curr.event == "dive" and "Face" in path_arr and "Crack" in path_arr and "Rocks" in path_arr and "Equipment" in path_arr and "Done" not in path_arr:
		newCurr("Story/Done")
	if Input.is_action_just_pressed("Hint"):
		newCurr("Story/InCrack")
		var closeOff = map.get_node("Int3")
		closeOff.Down = ""
	if cave_view.curr.Event == "InCrack":
		var posNode = map.get_node("Through")
		cave_view.tommy.position = posNode.position

func create_choices():
	if curr.choices.size() == 1:
		button.text = curr.choices[0]
	if curr.choices.size() == 2:
		button.text = curr.choices[0]
		button2.text = curr.choices[1]

func newCurr(path):
	curr = get_node(path)
	path_arr.append(curr.name)  
	char_index = 0
	text_timer.start()
	body.text = curr.text
	body.visible_characters = char_index
	button.text = ""
	button2.text = ""
	bb_num = 0
	if curr.event == "dive":
		code.startable = true
		char_index = body.text.length()
	else:
		code.startable = false
	if curr.event == "ore" and ore not in pic_lst:
		pic_lst.append(ore)
		title.text = "[center]Atlantica Cave[/center]"
	if curr.event == "face" and face not in pic_lst:
		pic_lst.append(face)
	if curr.event == "equipment" and equipment not in pic_lst:
		pic_lst.append(equipment)
	if curr.event == "crack" and crack not in pic_lst:
		pic_lst.append(crack)
	if curr.event == "wall" and wall not in pic_lst:
		pic_lst.append(wall)
	if curr.event == "secret" and secret not in pic_lst:
		pic_lst.append(secret)
	if curr.event == "cave_enter" and cave_enter not in pic_lst:
		pic_lst.append(cave_enter)
	
func _on_text_timer_timeout():
	if char_index+1 < body.text.length():
		if body.text[char_index] == '[':
			var bb_count = 0
			while body.text[char_index+bb_count] != ']':
				bb_count += 1
			bb_num += bb_count + 1
			char_index += bb_count
		if body.text[char_index] == '“':
			talking = true
		elif body.text[char_index] == '.':
			text_timer.stop()
			if talking == false:
				dot_timer.start()
			else:
				talk_timer.start()
		elif body.text[char_index] == '”':
			talking = false
			text_timer.stop()
			dot_timer.start()
		char_index += 1
		body.visible_characters = char_index-bb_num
	else:
		char_index += 1
		body.visible_characters = body.text.length()
		create_choices()

func _on_dot_timer_timeout():
	text_timer.start()
	
func _on_talk_timer_timeout():
	text_timer.start()
	
func _on_choice_button_pressed():
	if (curr.jumpToNode != "" and body.text.length() <= char_index):
		newCurr(curr.jumpToNode)

func _on_choice_button_2_pressed():
	if (curr.jumpToNode2 != "" and body.text.length() <= char_index):
		newCurr(curr.jumpToNode2)

