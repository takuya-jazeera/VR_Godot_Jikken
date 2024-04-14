extends Node3D

var t = 0.0
var qn = Quaternion(0.0,1.0,0.0,0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	qn = quaternion * qn * quaternion.inverse()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta 
	position = Vector3(0.0,0.0  ,-2.5) + t * 0.1 * qn.get_axis()
	if t > 30.0 :
		t = 0.0
	#pass
