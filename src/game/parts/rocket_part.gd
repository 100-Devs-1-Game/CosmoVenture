class_name RocketPart extends Sprite2D


@export var props: RocketPartProps

func draw_part(canvas: CanvasItem, pos: Vector2, pscale: float, alpha: float = 1.0) -> void:
	var size = get_rect().size
	canvas.draw_texture_rect_region(
		texture,
		Rect2(pos.x, pos.y, size.x * pscale, size.y * pscale),
		region_rect,
		Color(1, 1, 1, alpha))
