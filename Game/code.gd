extends Node2D

#Code start, timer start, timer resets when space is pressed, if timer timeout then one empty space

@onready var code_bar_timer = $CodeBarTimer
@onready var code_bar = $CodeBar
@onready var lit_bar = $LitBar
@onready var lit_bar2 = $LitBar2
@onready var lit_bar3 = $LitBar3
@onready var lit_bar4 = $LitBar4
@onready var lit_bar5 = $LitBar5
@onready var x_bar = $XBar
@onready var iterator = 0
@onready var lit_list = [lit_bar, lit_bar2, lit_bar3, lit_bar4, lit_bar5]

var on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if on:
		code_bar.visible = true
		
	if Input.is_action_just_pressed("Light") and on and iterator < 5:
		lit_list[iterator].visible = true
		iterator += 1
		code_bar_timer.start()
		
func _on_code_bar_timer_timeout():
	iterator += 1
