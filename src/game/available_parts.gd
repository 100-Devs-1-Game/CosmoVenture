class_name AvailableParts extends ItemList

var part_defs: SpaceCraftParts

func display_parts(_part_defs: SpaceCraftParts) -> void:
	part_defs = _part_defs
	for part in part_defs.parts:
		var tex = AtlasTexture.new()
		tex.atlas = part.texture
		tex.region = part.region_rect
		tex.filter_clip = true
		add_item(part.props.name, tex)


func _get_drag_data(_at_position: Vector2) -> Variant:
	var selected_items = get_selected_items()
	if selected_items.size() > 0:
		var index = selected_items[0]
		var preview = TextureRect.new()
		preview.stretch_mode = TextureRect.STRETCH_SCALE
		preview.texture = get_item_icon(index)
		preview.scale = Vector2(0.3, 0.3)
		set_drag_preview(preview)
		var part = part_defs.parts[index].props
		return part
	return null
