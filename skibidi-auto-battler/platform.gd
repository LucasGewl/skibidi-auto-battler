extends Node2D

var is_occipied = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_occupied(b):
	is_occipied = b
	
	
func get_occupied():
	return is_occipied
