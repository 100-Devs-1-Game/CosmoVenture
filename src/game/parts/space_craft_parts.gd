class_name SpaceCraftParts extends Node2D

@export var parts_by_type: Dictionary[GlobalInfo.RocketPartType, RocketPart] = {}

func get_part_by_type(type: GlobalInfo.RocketPartType) -> RocketPart:
	return parts_by_type.get(type)
