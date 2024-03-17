extends Node

@onready var title = $Background/TextContainers/TextPanels/TitleMargin/TitlePanel/TitleText
@onready var body = $Background/TextContainers/TextPanels/BodyPanel/BodyMargin/BodyText
@onready var text_timer = $TextTimer
@onready var dot_timer = $DotTimer
@onready var story = $Story

var char_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	title.text = "[center]Communications Room[/center]"
	body.text = story.text
	body.visible_characters = char_index


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_timer_timeout():
	if char_index+1 != body.text.length():
		if body.text[char_index] == '-':
			pass
		if body.text[char_index] == '”' or (body.text[char_index] == '.' and body.text[char_index+1] != '”'):
			text_timer.stop()
			dot_timer.start()
		char_index += 1
		body.visible_characters = char_index
	else:
		body.visible_characters = body.text.length()

func _on_dot_timer_timeout():
	char_index += 1
	text_timer.start()
