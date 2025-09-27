class_name Game extends Control

@onready var parts_scene: SpaceCraftParts = %SpaceCraftParts
@export var data: GameData

var is_launch_ready := false

func _ready() -> void:
	data.rocket.part_defs = parts_scene
	# Assemble on load of saved data.
	%HeadCheckButton.set_pressed_no_signal(data.rocket.has_part(GlobalInfo.RocketPartType.NoseMk1))
	%PodCheckButton.set_pressed_no_signal(data.rocket.has_part(GlobalInfo.RocketPartType.PodMk1))
	%FuelCheckButton.set_pressed_no_signal(data.rocket.has_part(GlobalInfo.RocketPartType.FuelMk1))
	%EngineCheckButton.set_pressed_no_signal(data.rocket.has_part(GlobalInfo.RocketPartType.ThrusterMk1))
	var assembly_line: AssemblyLine = get_node("%AssemblyLine")
	assembly_line.data = data
	_assemble()


func _assemble() -> void:
	var assembly_line: AssemblyLine = get_node("%AssemblyLine")
	assembly_line.assemble_craft()
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
	var assembly_line: AssemblyLine = get_node("%AssemblyLine")
	assembly_line.launch()
