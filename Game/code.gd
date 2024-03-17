extends Node2D

#Code start, timer start, timer resets when space is pressed, if timer timeout then one empty space

@onready var code_bar_timer = $CodeBarTimer
@onready var code_bar = $CodeBar
@onready var lit_bar = $LitBar

@onready var x_bar = $XBar
@onready var iterator = 0
@onready var x_bar_lst = []
@onready var lit_bar_lst = []
@onready var bar_lst = []

var on = true

var up = [1, 0, 0, 0, 0]
var down = [1, 0, 1, 0, 0]
var left = [1, 1, 0, 0, 0]
var right = [1, 1, 0, 1, 0]
var back = [1, 0, 0, 0, 1]
var code_lst = [up, down, left, right, back]

func _ready():
	pass
	
func _process(delta):
	if on:
		pass
		
	if Input.is_action_just_pressed("Light") and on and iterator < 5:
		bar_lst[iterator].append(1)
		iterator += 1
		code_bar_timer.start()
		
	if Input.is_action_just_pressed("Light") and on and iterator == 5: #cancel
		pass
		
func _on_code_bar_timer_timeout():
	if iterator < 5:
		code_lst[iterator].append(0)
	iterator += 1
