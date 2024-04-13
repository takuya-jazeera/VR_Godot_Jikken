
extends MeshInstance3D
var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	position = Vector3(0.0,0.0,-2.0 + 0.5* sin(t * 0.1))
	var theta = t * .8
	
	var p = Quaternion(cos(theta * 0.5),0.0,0.0,sin(theta* 0.5))
	var q = Quaternion(0.0,0.0,cos(theta * 0.5),sin(theta* 0.5))
	var r = Quaternion(0.0,cos(theta * 0.5),0.0,sin(theta* 0.5))

	quaternion = p * q * r
