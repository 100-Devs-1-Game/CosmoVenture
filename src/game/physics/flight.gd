class_name Flight extends Resource
## Represents on-going flight of a rocket in space.

# Our flying space craft.
@export var rocket: Rocket

# We assume only one globe affects the rocket.
# If null, it represents rocket to be outside of any
# significant gravitational force.
@export var closest_globe: Globe

# Distance from surface of the closest globe.
@export var d_surface_km: int

# Tilt of rocket relative to surface.
# 0 degree corresponds to straight up.
@export var tilt_deg: float

# Velocity is relative to closest globe if present.
# Otherwise it is space velocity.
@export var velocity_kms: Vector2

# Scale of screen in kms per px.
@export var scale_km_p_px: float

# Is current flight active.
@export var is_active: bool = false


func _init(
	p_rocket: Rocket,
	p_closest_globe: Globe,
	p_d_surface_km: int = 0,
	p_tilt_deg: float = 0.0,
	p_velocity_kms: Vector2 = Vector2(0.0, 0.0)) -> void:
		self.rocket = p_rocket
		self.closest_globe = p_closest_globe
		self.d_surface_km = p_d_surface_km
		self.tilt_deg = p_tilt_deg
		self.velocity_kms = p_velocity_kms

func start_flight() -> void:
	# Initialize any required parameters here.
	is_active = true
	scale_km_p_px = 1.0

func draw_flight(canvas: Control, dt: float) -> void:
	if !is_active:
		# Do not do anything if flight is not active.
		return

	var screen = canvas.get_rect()

	# TODO: Find how much of globe should be drawn. Draw the arc.
	# TODO: Calculate tilt of the rocket.
	# TODO: Tilt the rocket.

	# TODO: Calculate pos on screen.
	var f: float = rocket.get_force_n()
	var a: float = f - closest_globe.grav_at_h_km(d_surface_km)
	# TODO: dt needs to be scaled.
	# TODO: x component needs to be updated.
	var dy = a * dt
	if d_surface_km == 0 and dy < 0:
		dy = 0
	velocity_kms.y += dy

	@warning_ignore("narrowing_conversion")
	d_surface_km += velocity_kms.y * dt
	if d_surface_km < 0:
		d_surface_km = 0

	# Rocket remains in the middle.
	var pos = Vector2(canvas.size.x / 2, 0)
	# Keeping 1/10th space above rocket and below surface,
	pos.y = screen.size.y * (0.9) - d_surface_km - rocket.height * 0.2
	if pos.y < screen.size.y * 0.1:
		pos.y = screen.size.y * 0.1

	# TODO: Draw globe by scale
	var p1 = Vector2(0, screen.size.y * 0.9)
	var p2 = Vector2(screen.size.x, screen.size.y * 0.9)
	scale_km_p_px = max(1.0, d_surface_km / (screen.size.y * 0.8 - rocket.height * 0.2))
	var scaled_radius = closest_globe.radius_km / scale_km_p_px

	var center = Vector2(screen.size.x / 2, screen.size.y * 0.9 + scaled_radius)
	canvas.draw_arc(
		center,
		scaled_radius,
		(p1 - center).angle(),
		(p2 - center).angle(),
		10,
		Color.CADET_BLUE)

	# Draw rocket.
	rocket.draw_rocket(canvas, pos, 0.2)
	pass
