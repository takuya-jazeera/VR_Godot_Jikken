extends Node2D

@onready var panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	panel.size = get_window().size
	panel.get_node("L").size = Vector2i(300,300)
	panel.get_node("L").position = Vector2i(100,100)
	panel.get_node("R").size = Vector2i(300,300)
	panel.get_node("R").position = Vector2i(420,100)
	
	panel.get_node("L").material.set_shader_parameter("tex",$Main/ViewL.get_texture())
	panel.get_node("R").material.set_shader_parameter("tex",$Main/ViewR.get_texture())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
