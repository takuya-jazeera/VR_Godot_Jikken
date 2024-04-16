extends Node2D

@onready var panel = $Panel
@onready var view_height = get_window().size.y * 0.6
@onready var margin_horizontal = get_window().size.x * 0.1
@onready var debug_label = $grav
@onready var debug_gyro = $gyro
@onready var debug_theta = $theta

var theta = 0.0
var phi = 0.0
var cameras = []

# Called when the node enters the scene tree for the first time.
func _ready():
	cameras.append($Main/Camera/ViewL/CL)
	cameras.append($Main/Camera/ViewR/CR)
	pass 

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var grav = Input.get_gravity()
	debug_label.text = str(grav.x)  + " " + str(grav.y) + " " + str(grav.z)	
	var gyro = Input.get_gyroscope()
	debug_gyro.text = str(gyro.x) + " " + str(gyro.y) + " " + str(gyro.z)
	debug_gyro.text = str(gyro.x) + " " + str(gyro.y) + " " + str(gyro.z)	
	theta -= gyro.y * 0.1
	phi -= gyro.x * 0.1
	phi = clamp(phi, -PI * .5, PI * .5)
	
	var p = Quaternion(0.0,cos(theta*0.125),0.0,sin(theta*0.125))
	var q = Quaternion(cos(phi*0.5 + PI * 0.5),0.0,0.0,sin(phi*0.5 + PI *0.5)) 
	
	for cam in cameras :
		cam.quaternion = p * q


func _on_draw():
	panel.size = get_window().size
	view_height = panel.size.y * 0.6
	margin_horizontal = panel.size.x * 0.1
	
	var panel_l = panel.get_node("L")
	var panel_r = panel.get_node("R")
	
	
	var half_w = panel.size.x * .5
	panel.size = panel.size
	panel_l.size = Vector2i(view_height,view_height)
	panel_l.position = Vector2i(half_w - 50 - view_height ,panel.size.y*.2)
	panel_r.size = Vector2i(view_height,view_height)
	panel_r.position = Vector2i(half_w + 50,panel.size.y*.2)
	
	panel_l.material.set_shader_parameter("tex",$Main/Camera/ViewL.get_texture())
	panel_r.material.set_shader_parameter("tex",$Main/Camera/ViewR.get_texture())

	
	# Input.get_gravity()

