# TODO: @tool allows seeing redrawn items in 2D. Remove for actual game.
@tool
class_name AssemblyLine extends Control

@onready var parts_scene := preload("res://game/parts/space_craft_parts.tscn").instantiate()

var craft_parts: Array[Sprite2D] = []


func _ready() -> void:
	pass


func _draw() -> void:
	var x = 0
	var y = 0
	var width = 0
	var height = 0
	var pscale = 1
	for part in craft_parts:
		var part_size = part.get_rect().size
		width = max(width, part_size.x)
		height += part_size.y
		pscale = size.y / height
	pscale = min(pscale, 0.5)
	for part in craft_parts:
		var part_size = part.get_rect().size
		x = size.x / 2 - part_size.x / 2 * pscale
		draw_texture_rect_region(part.texture, Rect2(x, y, part_size.x * pscale, part_size.y * pscale),
			part.region_rect)
		y += part_size.y * pscale



func assemble_craft(data: GameData) -> void:
	craft_parts.clear()
	if !data.selected_head.is_empty():
		craft_parts.append(parts_scene.find_child(data.selected_head))
	if !data.selected_pod.is_empty():
		craft_parts.append(parts_scene.find_child(data.selected_pod))
	if !data.selected_fuel.is_empty():
		craft_parts.append(parts_scene.find_child(data.selected_fuel))
	if !data.selected_engine.is_empty():
		craft_parts.append(parts_scene.find_child(data.selected_engine))
	craft_parts = craft_parts.filter(func(part): return part != null)
	queue_redraw()


func launch() -> void:
	craft_parts.append(parts_scene.find_child("Thrust"))
	queue_redraw()
