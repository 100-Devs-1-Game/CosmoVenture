class_name Rocket extends Resource

@export var part_types: Array[GlobalInfo.RocketPartType]

@export var mass_kg: float # Not weight
@export var height: float
@export var width: float
@export var fuel_kg: float
@export var fuel_burn_rate_kgps: float


# Someone must initialize part definitions.
var part_defs: SpaceCraftParts


func get_parts() -> Array[RocketPart]:
	var parts: Array[RocketPart] = []
	if part_defs == null:
		return parts
	for t in part_types:
		parts.append(part_defs.get_part_by_type(t))
	return parts


func add_part(part: GlobalInfo.RocketPartType) -> void:
	# TODO: Set order
	if !has_part(part):
		part_types.append(part)


func remove_part(part: GlobalInfo.RocketPartType) -> void:
	if has_part(part):
		part_types.remove_at(part_types.find(part))


func has_part(part: GlobalInfo.RocketPartType) -> bool:
	return part in part_types


func is_launch_ready() -> bool:
	return (has_part(GlobalInfo.RocketPartType.NoseMk1)
		&& has_part(GlobalInfo.RocketPartType.PodMk1)
		&& has_part(GlobalInfo.RocketPartType.FuelMk1)
		&& has_part(GlobalInfo.RocketPartType.ThrusterMk1))


func get_force_n() -> int:
	# TODO: Save parts as resource.
	# Last part must be the thuster.
	var bottom_part = part_types[-1] # part_types.get(part_types.size() - 1)
	if bottom_part == GlobalInfo.RocketPartType.ThrusterMk1:
		var thruster: RocketPart = part_defs.get_part_by_type(bottom_part)
		return thruster.props.force_n
	return 0


func calc_props() -> void:
	var w = 0.0
	var h = 0.0
	var m = 0.0
	var parts = get_parts()
	for p in parts:
		w = max(w, p.get_rect().size.x)
		h += p.get_rect().size.y
		m += p.props.mass_kg
	width = w
	height = h
	mass_kg = m

# pos represents the top middle point of the rocket.
func draw_rocket(canvas: Control, pos: Vector2, max_scale: float = 1.0) -> void:
	var w = 0.0
	var h = 0.0
	var parts = get_parts()
	var pscale = 1.0
	for p in parts:
		w = max(w, p.get_rect().size.x)
		h += p.get_rect().size.y
		pscale = canvas.size.y / h
	pscale = min(max_scale, 0.5)
	for p in parts:
		var part_size = p.get_rect().size
		pos.x = canvas.size.x / 2 - part_size.x / 2 * pscale
		p.draw_part(canvas, pos, pscale)
		pos.y += part_size.y * pscale
	height = h
