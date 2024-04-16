extends Node3D

@onready var neko = $nekonobou
@onready var caption = $Node3D
var t = 0

#var cameras = [];
@onready var cam = $Camera

# Called when the node enters the scene tree for the first time.
func _ready():
	#cameras.append($Camera/ViewL/CL)
	#cameras.append($Camera/ViewR/CR)
	#pass # Replace with function body.
	var anim = neko.get_node("AnimationPlayer")
	anim.play("walking")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t+= delta
	var x = Input.get_axis("ui_down","ui_up")
	var gzi = t * 0.4
	neko.position = - 5.5 * Vector3(0.0,0.0,1.0) + 4.0 * Vector3(cos(gzi),0.0,sin(gzi))
	neko.quaternion = Quaternion(0.0,cos((gzi - PI * 0.5) * 0.5),0.0,sin((gzi - PI) * 0.5))
	
	caption.scale = (1.0 + 0.2 * sin(t)) * Vector3(1.0,1.0,1.0)
	#for cam in cameras :
	#position -= x * 0.1 * Vector3(0.0,0.0,1.0)

