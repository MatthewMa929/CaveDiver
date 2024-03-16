extends Node2D

#Code start, timer start, timer resets when space is pressed, if timer timeout then one empty space

@onready var code_bar_timer = $CodeBarTimer
@onready var code_bar = $CodeBar
@onready var lit_bar = $LitBar

@onready var x_bar = $XBar
@onready var iterator = 0
@onready var x_bar_lst = []
@onready var lit_bar_lst = []

var on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	while iterator < 5:
		var x_dup = x_bar.duplicate()
		add_child(x_dup)
		x_dup.position.x += 100*iterator
		var lit_dup = lit_bar.duplicate()
		add_child(lit_dup)
		lit_dup.position.x += 100*iterator
		x_bar_lst.append(x_dup)
		lit_bar_lst.append(lit_dup)
		iterator += 1
	iterator = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if on:
		code_bar.visible = true
		
	if Input.is_action_just_pressed("Light") and on and iterator < 5:
		lit_bar_lst[iterator].visible = true
		iterator += 1
		code_bar_timer.start()
		
	if Input.is_action_just_pressed("Light") and on and iterator == 5: #cancel
		pass
		
		
func _on_code_bar_timer_timeout():
	if iterator < 5:
		x_bar_lst[iterator].visible = true
	iterator += 1
