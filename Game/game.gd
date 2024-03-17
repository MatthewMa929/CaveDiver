extends Control

@onready var title = $Background/TextContainers/TextPanels/TitleMargin/TitlePanel/TitleText
@onready var body = $Background/TextContainers/TextPanels/BodyPanel/BodyMargin/BodyText
@onready var text_timer = $TextTimer
@onready var dot_timer = $DotTimer

var char_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	title.text = "[center]Communications Room[/center]"
	body.text = """What kind of relocation is this…
You step into a run down room with generic company posters, random boxes and a computer.
You sigh, but resign yourself to your new position. “I had guessed I was getting demoted, but this is just ridiculous.” 
Taking a seat in front of the old computer, you wait for your shift to officially start while you take sips of your coffee. 
Suddenly the computer makes a bleep noise.
“Hi, hello, is anyone there?”
“Hi, this is Sandra, your new supervisor. Could this be Tommy?”
“Ah yeah that's me. I’m glad you’re here early. Last guy I was assigned with was an hour late. Not hard to tell why he was replaced." """
	body.visible_characters = char_index


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_timer_timeout():
	if char_index+1 != body.text.length():
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
