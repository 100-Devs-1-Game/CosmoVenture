class_name Game extends Control

@export var data: GameData
@onready var part_defs = preload("res://game/parts/space_craft_parts.tscn").instantiate()


func _ready() -> void:
	add_child(part_defs)
	data.rocket.part_defs = part_defs
	%AvailableParts.display_parts(data.rocket.part_defs)
	%World.data = data
	%Sim.data = data
	if data.flight != null and data.flight.is_active:
		# TODO: Start flight in paused mode.
		pass
