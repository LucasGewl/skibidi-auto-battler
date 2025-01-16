extends StaticBody2D

var offset : Vector2
var initial_pos : Vector2
var curr_platform
var prev_platform
var is_draggable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("platform"):
			curr_platform = i
		else:
			curr_platform = null
	print(global_position.distance_to(get_global_mouse_position()))
	print($CollisionShape2D.shape.radius)

	# Start dragging the unit
	if Input.is_action_just_pressed("left_mouse") and global_position.distance_to(get_global_mouse_position()) <= $CollisionShape2D.shape.radius:
		initial_pos = global_position
		offset = get_global_mouse_position() - global_position
		is_draggable = true
	if is_draggable:
		if Input.is_action_pressed("left_mouse"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("left_mouse"):
			var tween = get_tree().create_tween()
			is_draggable = false
			if curr_platform and not curr_platform.get_occupied():
				if prev_platform:
					prev_platform.set_occupied(false)
				curr_platform.set_occupied(true)
				initial_pos = position
				prev_platform = curr_platform
				tween.tween_property(self, "position", curr_platform.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_OUT)
