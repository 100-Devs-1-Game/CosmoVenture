class_name RocketPart extends Sprite2D


@export var type: GlobalInfo.RocketPartType
@export var massKg: int

func draw_part(canvas: CanvasItem, pos: Vector2, pscale: float) -> void:
	var size = get_rect().size
	canvas.draw_texture_rect_region(
		texture,
		Rect2(pos.x, pos.y, size.x * pscale, size.y * pscale),
		region_rect)
