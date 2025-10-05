class_name RocketPartProps extends Resource

@export var name: String
@export var type: GlobalInfo.RocketPartType
@export var mass_kg: int # Base mass, not including fuel mass

# Only for fuel containers
@export var max_fuel_kg: float
@export var remaining_fuel_kg: float

# Only for thrusters
@export var fuel_burn_rate_kgps: int
@export var force_n: int
