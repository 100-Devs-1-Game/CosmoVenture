class_name World extends Control


var data: GameData
var is_paused := false
var dt: float = 0.0


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	dt = 0.0
	if is_paused:
		return
	if data.flight == null or !data.flight.is_active:
		# Nothing to process if not simulating.
		return
	dt = delta
	queue_redraw()


func _draw() -> void:
	if data.flight != null and data.flight.is_active:
		data.flight.draw_flight(self, dt)
		%SpeedLabel.text = "Speed: %0d" % data.flight.velocity_kms.length()
		%HeightLabel.text = "Altitude: " + str(data.flight.d_surface_km)
		%MassLabel.text = "Mass: " + str(data.flight.rocket.mass_kg)
		%ThrustLabel.text = "Thrust: " + str(data.flight.rocket.get_force_n())
	else:
		data.rocket.draw_rocket(self, Vector2(get_rect().size.x / 2, 0.0))


func assemble_craft() -> void:
	data.flight = null
	is_paused = false
	%PlayButton.text = "Pause"
	queue_redraw()


func launch() -> void:
	# Create a flight.

	# Duplicate rocket because data.rocket represents its full
	# configuration, while flight rocket is its current state.
	# This state includes remaining fuel and remaining modules.
	var flight_rocket = data.rocket.duplicate(true)
	flight_rocket.part_defs = data.rocket.part_defs
	flight_rocket.calc_props(self)
	var flight = Flight.new(	flight_rocket, Globe.Earth.new())
	data.flight = flight
	flight.start_flight()


func _on_play_button_pressed() -> void:
	if data.flight == null or !data.flight.is_active:
		return
	is_paused = !is_paused
	if is_paused:
		%PlayButton.text = "Resume"
	else:
		%PlayButton.text = "Pause"


func _on_restart_button_pressed() -> void:
	if data.flight != null and data.flight.is_active:
		is_paused = false
		%PlayButton.text = "Pause"
		data.flight = null
		launch()


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
