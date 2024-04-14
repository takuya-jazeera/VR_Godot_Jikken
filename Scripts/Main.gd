extends Node3D

var cameras = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	cameras.append($ViewL/CL)
	cameras.append($ViewR/CR)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = Input.get_axis("ui_down","ui_up")
	for cam in cameras :
		cam.position -= x * 0.1 * Vector3(0.0,0.0,1.0)
