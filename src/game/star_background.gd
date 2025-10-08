extends ColorRect

@export var num_stars: int= 500

func _draw() -> void:
	for i in num_stars:
		var pos:= Vector2(randf_range(0, custom_minimum_size.x), randf_range(0, custom_minimum_size.y))
		draw_circle(pos, 2, Color.WHITE)
