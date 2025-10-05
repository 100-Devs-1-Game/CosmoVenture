class_name Game extends Control

@export var data: GameData
@onready var part_defs = preload("res://game/parts/space_craft_parts.tscn").instantiate()


func _ready() -> void:
	add_child(part_defs)
	data.rocket.part_defs = part_defs
	%AvailableParts.display_parts(data.rocket.part_defs)
	_get_world().data = data
	if data.flight != null and data.flight.is_active:
		# TODO: Start flight in paused mode.
		pass
	_assemble()


func _get_world() -> World:
	return get_node("%World")


func _assemble() -> void:
	_get_world().assemble_craft()
	%LaunchButton.disabled = !data.rocket.is_launch_ready()


func _toggle_part(part: GlobalInfo.RocketPartType, toggle_on: bool) -> void:
	if toggle_on:
		if !data.rocket.has_part(part):
			data.rocket.add_part(part)
	else:
		if data.rocket.has_part(part):
			data.rocket.remove_part(part)
	_assemble()


func _on_head_check_button_toggled(toggled_on: bool) -> void:
	_toggle_part(GlobalInfo.RocketPartType.NoseMk1, toggled_on)


func _on_pod_check_button_toggled(toggled_on: bool) -> void:
	_toggle_part(GlobalInfo.RocketPartType.PodMk1, toggled_on)


func _on_fuel_check_button_toggled(toggled_on: bool) -> void:
	_toggle_part(GlobalInfo.RocketPartType.FuelMk1, toggled_on)


func _on_engine_check_button_toggled(toggled_on: bool) -> void:
	_toggle_part(GlobalInfo.RocketPartType.ThrusterMk1, toggled_on)


func _on_launch_button_pressed() -> void:
	_get_world().launch()
