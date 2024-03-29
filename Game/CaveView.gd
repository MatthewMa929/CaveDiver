extends SubViewport

@onready var tommy = $Tommy
@onready var cam = $Camera2D
@onready var view1 = $View1
@onready var view2 = $View2
@onready var view3 = $View3
@onready var curr = owner.find_child("Entrance")
@onready var map_lst = [view1, view2, view3]

var map_vis = 0
var x_spd = 0
var y_spd = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	tommy.position = curr.position
	
func _physics_process(delta):
	cam.position = tommy.position
	if Input.is_action_just_pressed("Next Map"):
		map_vis += 1
		if map_vis > 2:
			map_vis = 0
	for i in map_lst:
		i.visible = false
	map_lst[map_vis].visible = true
	if tommy.position.y > curr.position.y: #Up
		tommy.position.y += -.15 #(tommy.position.y - curr.position.y)
	if tommy.position.y < curr.position.y: #Down
		tommy.position.y += .15 
	if tommy.position.x > curr.position.x: #Left
		tommy.position.x += -.15
	if tommy.position.x < curr.position.x: #Right
		tommy.position.x += .15

func _on_code_code_sent(sent):
	if curr.Up != "" and sent == "up":
		curr = owner.find_child(curr.Up)
	if curr.Down != "" and sent == "down":
		curr = owner.find_child(curr.Down)
	if curr.Left != "" and sent == "left":
		curr = owner.find_child(curr.Left)
	if curr.Right != "" and sent == "right":
		curr = owner.find_child(curr.Right)
	x_spd =	(tommy.position.x - curr.position.x)/100
	y_spd = (tommy.position.y - curr.position.y)/100
