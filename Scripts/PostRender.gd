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

# pc
var bIsCalibrating = false
# android
#var bIsCalibrating = true

#var prev_mouse_position = Vector2i(0,0)

@onready var pre_rot = $Main/Camera.quaternion
@onready var next_rot = pre_rot

var interval = 0.0
const interpoletime = 0.15

# Called when the node enters the scene tree for the first time.
func _ready():
	cameras.append($Main/Camera/ViewL/CL)
	cameras.append($Main/Camera/ViewR/CR)
	
	panel.hide()
	
	# Disable Mouse ovelay
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#pass 

	

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
	else :
		
		$cal.hide()
		panel.show()
	
		theta -= gyro.y * 0.1
		phi -= gyro.x * 0.1
		phi = clamp(phi, -PI * .5, PI * .5)
		psi += gyro.z * 0.02
		psi = clamp(psi, -PI * .5, PI * .5)
		
		interval += delta
		if interval > interpoletime  :
			interval = 0.0
			pre_rot = next_rot
			if grav.y < -9.75 :
				next_rot = Quaternion(0.0,cos(theta*0.125 + PI * 0.5),0.0,sin(theta*0.125 + PI * 0.5))
				phi = 0.0
				psi = 0.0
			else :
				var p = Quaternion(0.0,cos(theta*0.125 + PI * 0.5),0.0,sin(theta*0.125 + PI * 0.5))
				var q = Quaternion(cos(phi*0.5 + PI * 0.5),0.0,0.0,sin(phi*0.5 + PI *0.5)) 
				var r = Quaternion(0.0,0.0,cos(psi * 0.25 + PI * 0.5),sin(psi * 0.25 + PI * 0.5))
				next_rot = p * r * q
	
		for cam in cameras :
			cam.quaternion = pre_rot.slerp(next_rot,interval/interpoletime)

		#var forward = Input.get_axis("ui_up","ui_down")
		#var horizontal = Input.get_axis("ui_left","ui_right")
		
		
		
		var p = Quaternion(0.0,cos(theta*0.125 + PI * 0.5),0.0,sin(theta*0.125 + PI * 0.5))
		var q = p * Quaternion(0.0,0.0,1.0,0.0) * p.inverse()
		var r = p * Quaternion(1.0,0.0,0.0,0.0) * p.inverse()
		
		var mouse_position = Input.get_last_mouse_velocity()
		mouse_position = mouse_position.normalized()
		var forward = mouse_position.y
		var horizontal = mouse_position.x
		
		#f Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
		#forward = 1.0
		#lse :
		#forward = 0.0
			
		#get_viewport().update_mouse_cursor_state(Input.mouse) = get_window().size * 0.5
		
		for cam in cameras :
			if abs(forward) :
				cam.position += 0.05* q.get_axis() * forward
			if abs(horizontal) :
				cam.position += 0.05 *q.get_axis() * horizontal
		
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

