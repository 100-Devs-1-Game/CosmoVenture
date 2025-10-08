class_name World extends Control


var data: GameData


func _draw() -> void:
	if data.rocket != null:
		%PreviewMassLabel.text = "Mass: " + str(data.rocket.mass_kg)
		%PreviewThrustLabel.text = "Thrust: " + str(data.rocket.get_force_n())
	data.rocket.draw_rocket(self, Vector2(get_rect().size.x / 2, 0.0))


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and not get_viewport().gui_is_drag_successful() and data.rocket != null:
		data.rocket.ephemeral_part = null
		data.rocket.ephemeral_part_pos = Vector2(0, 0)
		data.rocket.ephemeral_part_index = -1
		data.rocket.calc_props(self)
		queue_redraw()


func _can_drop_data(at_position: Vector2, drop_data: Variant) -> bool:
	if drop_data is RocketPartProps:
		_add_part(at_position, drop_data, true)
		return true
	return false


func _drop_data(at_position: Vector2, drop_data: Variant) -> void:
	if drop_data is RocketPartProps:
		_add_part(at_position, drop_data)



func _add_part(pos: Vector2, part: RocketPartProps, ephemeral: bool = false) -> void:
	if data.rocket == null:
		data.rocket = Rocket.new()
	var rocket = data.rocket

	if rocket.parts == null:
		rocket.parts = []

	if ephemeral:
		rocket.ephemeral_part = part
		rocket.ephemeral_part_pos = pos
		rocket.ephemeral_part_index = -1
	else:
		rocket.parts.insert(rocket.ephemeral_part_index, part)
		rocket.ephemeral_part = null
		rocket.ephemeral_part_pos = Vector2(0, 0)
		rocket.ephemeral_part_index = -1
	rocket.calc_props(self)
	queue_redraw()
