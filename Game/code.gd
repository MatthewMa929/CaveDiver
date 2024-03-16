extends Node2D

#Code start, timer start, timer resets when space is pressed, if timer timeout then one empty space

@onready var code_bar = $CodeBarProgress
@onready var code_bar_timer = $CodeBarTimer
@onready var lit_bar = $LitBar
@onready var lit_bar2 = $LitBar2
@onready var lit_bar3 = $LitBar3
@onready var lit_bar4 = $LitBar4
@onready var lit_bar5 = $LitBar5

var on = true
var done = false
var num = 300.0/593

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if on:
		done = false
		code_bar.value += 1
	if code_bar.value == code_bar.max_value:
		on = false
		done = true
	if Input.is_action_pressed("Light") and on:
		print(num)
		if code_bar.value > 0*num and code_bar.value < 100*num:
			lit_bar.visible = true
		if code_bar.value > 100*num and code_bar.value < 200*num:
			lit_bar2.visible = true
		if code_bar.value > 200*num and code_bar.value < 300*num:
			lit_bar3.visible = true
		if code_bar.value > 300*num and code_bar.value < 400*num:
			lit_bar4.visible = true
		if code_bar.value > 400*num and code_bar.value < 500*num:
			lit_bar5.visible = true


func _on_code_bar_timer_timeout():
	pass

