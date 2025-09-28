class_name Globe extends Resource
## Represents all planets or starts that exert gravitational field for rockets.
## Sub-classes are not saved, so this resource is not really meant to save,
## but only acts as an object to encapsulate a celestial body.
## That is why no variable is exported, but only declared for sub-classes
## to override.


var radius_km: float
var grav_at_surface_ms2: float


func grav_at_h_km(h: int) -> float:
	# Same grav as at surface if height is less than 5% of radius.
	if h * 20 < radius_km:
		return grav_at_surface_ms2
	# Use approximation if height is less than 10% of radius.
	if h * 10 < radius_km:
		return grav_at_surface_ms2 * (1 - 2 * h / radius_km)
	var ratio = radius_km / (radius_km + h)
	return grav_at_surface_ms2 * ratio * ratio

class Earth extends Globe:
	func _init() -> void:
		self.radius_km = 6400 # Approx from 6371
		self.grav_at_surface_ms2 = 10.0 # Approx from 9.8
