extends Node2D

@onready var panel = $Panel
@onready var view_height = get_window().size.y * 0.6
@onready var margin_horizontal = get_window().size.x * 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_draw():
	panel.size = get_window().size
	view_height = get_window().size.y * 0.6
	margin_horizontal = get_window().size.x * 0.2
	
	var panel_l = panel.get_node("L")
	var panel_r = panel.get_node("R")
	
	panel.size = get_window().size
	panel_l.size = Vector2i(view_height,view_height)
	panel_l.position = Vector2i(margin_horizontal,100)
	panel_r.size = Vector2i(view_height,view_height)
	panel_r.position = Vector2i(get_window().size.x- view_height - margin_horizontal,100)
	
	panel_l.material.set_shader_parameter("tex",$Main/ViewL.get_texture())
	panel_r.material.set_shader_parameter("tex",$Main/ViewR.get_texture())

