extends Node2D

@onready var panel = $Panel
@onready var view_height = get_window().size.y * 0.6
@onready var margin_horizontal = get_window().size.x * 0.1
@onready var debug_label = $grav
@onready var debug_gyro = $gyro
@onready var debug_theta = $theta

var theta = PI
var phi = 0.0
var psi = 0.0
var cameras = []
var bIsCalibrating = true

@onready var pre_rot = $Main/Camera.quaternion
@onready var next_rot = pre_rot

var interval = 0.0
const interpoletime = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	cameras.append($Main/Camera/ViewL/CL)
	cameras.append($Main/Camera/ViewR/CR)
	
	panel.hide()
	pass 

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var grav = Input.get_gravity()
	var gyro = Input.get_gyroscope()
	debug_label.text = str(grav.x)  + " " + str(grav.y) + " " + str(grav.z)	
	debug_gyro.text = str(gyro.x) + " " + str(gyro.y) + " " + str(gyro.z)
	debug_gyro.text = str(gyro.x) + " " + str(gyro.y) + " " + str(gyro.z)	
	
	if bIsCalibrating :
		$cal.show()
		if grav.y < -9.76 && abs(grav.x) < 0.02:
			bIsCalibrating = false
			$cal.hide()
			panel.show()
	else :
	
		theta -= gyro.y * 0.1
		phi -= gyro.x * 0.1
		phi = clamp(phi, -PI * .5, PI * .5)
		psi += gyro.z * 0.02
		psi = clamp(psi, -PI * .5, PI * .5)
		
		interval += delta
		if interval > interpoletime  :
			interval = 0.0
			pre_rot = next_rot
			if grav.y < -9.7 :
				next_rot = Quaternion(0.0,cos(theta*0.125 + PI * 0.5),0.0,sin(theta*0.125 + PI * 0.5))
			else :
				var p = Quaternion(0.0,cos(theta*0.125 + PI * 0.5),0.0,sin(theta*0.125 + PI * 0.5))
				var q = Quaternion(cos(phi*0.5 + PI * 0.5),0.0,0.0,sin(phi*0.5 + PI *0.5)) 
				var r = Quaternion(0.0,0.0,cos(psi * 0.25 + PI * 0.5),sin(psi * 0.25 + PI * 0.5))
				next_rot = p * r * q
	
		for cam in cameras :
			cam.quaternion = pre_rot.slerp(next_rot,interval/interpoletime)


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

