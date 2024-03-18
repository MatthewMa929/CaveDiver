extends Node

@onready var title = $Background/TextContainers/TextPanels/TitleMargin/TitlePanel/TitleText
@onready var body = $Background/TextContainers/TextPanels/BodyPanel/BodyMargin/BodyText
@onready var text_timer = $TextTimer
@onready var dot_timer = $DotTimer
@onready var story = $Story
@onready var button = $ChoiceMargin/ChoiceButtons/ChoiceButton
@onready var button2 = $ChoiceMargin/ChoiceButtons/ChoiceButton2
@onready var curr = story

var char_index = 0
var path_arr = [0]

# Called when the node enters the scene tree for the first time.
func _ready():
	title.text = "[center]Communications Room[/center]"
	body.text = curr.text
	body.visible_characters = char_index


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Action"):
		char_index = body.text.length()

func _on_text_timer_timeout():
	if char_index+1 < body.text.length():
		if body.text[char_index] == '-':
			pass
		if body.text[char_index] == '”' or (body.text[char_index] == '.' and body.text[char_index+1] != '”'):
			text_timer.stop()
			dot_timer.start()
		char_index += 1
		body.visible_characters = char_index
	else:
		body.visible_characters = body.text.length()
		create_choices()

func create_choices():
	if curr.choices.size() == 1:
		button.text = curr.choices[0]
	if curr.choices.size() == 2:
		button.text = curr.choices[0]
		button2.text = curr.choices[1]

func _on_dot_timer_timeout():
	char_index += 1
	text_timer.start()

func _on_choice_button_pressed():
	if (curr.jumpToNode != "" and body.text.length() <= char_index):
		newCurr(curr.jumpToNode)

func _on_choice_button_2_pressed():
	if (curr.jumpToNode2 != "" and body.text.length() <= char_index):
		newCurr(curr.jumpToNode2)

func newCurr(path):
	curr = get_node(path)
	path_arr.append(curr.pathNumber)
	char_index = 0
	text_timer.start()
	body.text = curr.text
	body.visible_characters = char_index
	button.text = ""
	button2.text = ""
