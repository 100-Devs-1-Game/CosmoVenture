class_name Sim extends Control


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
		
		# max_height is when the ship has left the atmosphere
		var max_height:= 10000.0
		var height_ratio:= data.flight.d_surface_km / max_height
		%"Flight Background".color= Color.SKY_BLUE.lerp(Color.BLACK, height_ratio)

		%"Parallax2D Stars".show()
		# fade stars in slowly depending on current height vs max_height
		%"Parallax2D Stars".modulate.a= pow(height_ratio, 4)
		# scroll the stars background depending on the ships velocity
		%"Parallax2D Stars".autoscroll= data.flight.velocity_kms * 0.01
		
		%SimSpeedLabel.text = "Speed: %0d" % data.flight.velocity_kms.length()
		%SimHeightLabel.text = "Altitude: " + str(data.flight.d_surface_km)
		%SimMassLabel.text = "Mass: " + str(data.flight.rocket.mass_kg)
		%SimThrustLabel.text = "Thrust: " + str(data.flight.rocket.get_force_n())
	else:
		data.rocket.draw_rocket(self, Vector2(get_rect().size.x / 2, 0.0))


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


func _on_launch_button_pressed() -> void:
	launch()
