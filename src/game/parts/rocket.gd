class_name Rocket extends Resource

@export var parts: Array[RocketPartProps]

# Ephemeral part is added to a rocket at the time of assembly.
var ephemeral_part_pos := Vector2(0, 0)
var ephemeral_part: RocketPartProps
var ephemeral_part_index: int = -1 # Computed

@export var mass_kg: float # Not weight
@export var height: float
@export var width: float
@export var fuel_kg: float
@export var fuel_burn_rate_kgps: float


# Someone must initialize part definitions.
var part_defs: SpaceCraftParts


func get_force_n() -> int:
	# Last part must be the thuster.
	if parts.size() > 0:
		var bottom_part = parts[-1] # part_types.get(part_types.size() - 1)
		return bottom_part.force_n
	return 0


func calc_props(canvas: Control) -> void:
	var w = 0.0
	var h = 0.0
	var m = 0.0
	var cumulative_heights = []
	for p in parts:
		var def = part_defs.get_part_by_type(p.type)
		w = max(w, def.get_rect().size.x)
		h += def.get_rect().size.y
		cumulative_heights.append(h)
		m += p.mass_kg

	var pscale = 1.0
	# Compute index for ephemeral part
	if ephemeral_part != null:
		var def = part_defs.get_part_by_type(ephemeral_part.type)
		w = max(w, def.get_rect().size.x)
		h += def.get_rect().size.y
		pscale = min(1.0, canvas.size.y / h)
		for i in range(parts.size()):
			var ht_till_now = cumulative_heights[i] * pscale
			if ephemeral_part_pos.y < ht_till_now:
				ephemeral_part_index = i
				break
		if ephemeral_part_index == -1:
			ephemeral_part_index = parts.size() # Add at the bottom
	else:
		ephemeral_part_index = -1

	width = w
	height = h
	mass_kg = m

# pos represents the top middle point of the rocket.
func draw_rocket(canvas: Control, pos: Vector2, max_scale: float = 1.0) -> void:
	if height == 0.0:
		calc_props(canvas)
	var pscale = canvas.size.y / height
	pscale = min(max_scale, pscale)
	var num_parts = parts.size()
	if ephemeral_part != null:
		num_parts += 1
	var index = 0
	for i in range(num_parts):
		var p: RocketPartProps
		var is_ephemeral = false
		if i == ephemeral_part_index:
			p = ephemeral_part
			is_ephemeral = true
		else:
			p = parts[index]
			index += 1

		var def = part_defs.get_part_by_type(p.type)
		var part_size = def.get_rect().size
		pos.x = canvas.size.x / 2 - part_size.x / 2 * pscale
		var alpha = 1.0
		if is_ephemeral:
			alpha = 0.5
		def.draw_part(canvas, pos, pscale, alpha)
		pos.y += part_size.y * pscale
