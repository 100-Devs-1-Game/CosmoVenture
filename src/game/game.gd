class_name Game extends Control

@export var data: GameData

var is_launch_ready := false

func _ready() -> void:
	# Assemble on load of saved data.
	%HeadCheckButton.set_pressed_no_signal(!data.selected_head.is_empty())
	%PodCheckButton.set_pressed_no_signal(!data.selected_pod.is_empty())
	%FuelCheckButton.set_pressed_no_signal(!data.selected_fuel.is_empty())
	%EngineCheckButton.set_pressed_no_signal(!data.selected_engine.is_empty())
	_assemble()


func _assemble() -> void:
	var assembly_line: AssemblyLine = get_node("%AssemblyLine")
	assembly_line.assemble_craft(data)
	is_launch_ready = (!data.selected_head.is_empty()
						&& !data.selected_pod.is_empty()
						&& !data.selected_fuel.is_empty()
						&& !data.selected_engine.is_empty())
	print("Is launch read? " + str(is_launch_ready))
	%LaunchButton.disabled = !is_launch_ready


func _on_head_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		data.selected_head = "HeadMk1"
	else:
		data.selected_head = ""
	_assemble()


func _on_pod_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		data.selected_pod = "PodMk1"
	else:
		data.selected_pod = ""
	_assemble()


func _on_fuel_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		data.selected_fuel = "FuelMk1"
	else:
		data.selected_fuel = ""
	_assemble()


func _on_engine_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		data.selected_engine = "EngineMk1"
	else:
		data.selected_engine = ""
	_assemble()


func _on_launch_button_pressed() -> void:
	var assembly_line: AssemblyLine = get_node("%AssemblyLine")
	assembly_line.launch()
