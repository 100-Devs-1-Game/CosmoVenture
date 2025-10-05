class_name SpaceCraftParts extends Node2D


@export var parts: Array[RocketPart] = []

var parts_by_type: Dictionary[GlobalInfo.RocketPartType, RocketPart] = {}

func _ready() -> void:
	for p in parts:
		parts_by_type[p.props.type] = p

func get_part_by_type(type: GlobalInfo.RocketPartType) -> RocketPart:
	return parts_by_type.get(type)
