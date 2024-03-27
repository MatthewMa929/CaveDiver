extends Node2D

#Code start, timer start, timer resets when space is pressed, if timer timeout then one empty space

@onready var code_bar_timer = $CodeBarTimer
@onready var dot = $Dot 
@onready var empty = $Empty

@onready var iterator = 0
@onready var bar_lst = []

var startable = false
var on = false
var sent = ""
var pos_x = 160
var dot_lst = []
var empty_lst = []

var up = [1, 0, 0, 0]
var down = [1, 0, 1, 0]
var left = [1, 1, 0, 0]
var right = [1, 1, 0, 1]
var stop = [1, 1, 1, 1]
var ask_state = [1, 0, 0, 1]
var code_lst = [up, down, left, right, stop, ask_state]

#Tommy code
var okT = [1, 0, 0, 0]
var need_airT = [1, 1, 0, 0]
var photoT = [1, 1, 1, 0]
var mineralT = [1, 1, 1, 1]
var returnT = [0, 0, 0, 1]
var dangerT = [1, 0, 1, 0]

signal code_sent(sent)

func _ready():
	for i in range(4):
		var new_dot = dot.duplicate()
		add_child(new_dot)
		new_dot.position = Vector2(pos_x+i*30, 506)
		new_dot.visible = false
		dot_lst.append(new_dot)
		var new_empty = empty.duplicate()
		add_child(new_empty)
		new_empty.position = Vector2(pos_x+i*30, 506)
		new_empty.visible = false
		empty_lst.append(new_empty)
	
func _process(delta):
	if not on and startable and Input.is_action_just_pressed("Action"):
		on = true
		
	if Input.is_action_just_pressed("Action") and on and iterator < 4:
		dot_lst[iterator].visible = true
		bar_lst.append(1)
		iterator += 1
		code_bar_timer.start()
		
	if on and iterator == 4: #Finish
		print(bar_lst)
		for i in range(4):
			dot_lst[i].visible = false
			empty_lst[i].visible = false
		code_bar_timer.stop()
		compare_bar_lst()
		bar_lst = []
		sent = ""
		on = false
		iterator = 0
		
func compare_bar_lst():
	if bar_lst == up:
		sent = "up"
	if bar_lst == down:
		sent = "down"
	if bar_lst == left:
		sent = "left"
	if bar_lst == right:
		sent = "right"
	code_sent.emit(sent)

func _on_code_bar_timer_timeout():
	if iterator < 4:
		empty_lst[iterator].visible = true
		bar_lst.append(0)
	iterator += 1
		
