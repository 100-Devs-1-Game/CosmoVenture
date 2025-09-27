class_name AssemblyLine extends Control


var is_sim := false
var max_scale := 0.5
var craft_at_y := 0

var data: GameData
var velocity := Vector2(0, 0)


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if !is_sim:
		# Nothing to process if not simulating.
		craft_at_y = 0
		max_scale = 1
		return

	var a = (1000 - 50)/50.0 - 10
	var v = velocity + Vector2(0, a * _delta)
	max_scale = 0.2
	craft_at_y -= v.y * _delta
	
	velocity = v
	%SpeedLabel.text = "Speed: " + str(velocity.length())
	%HeightLabel.text = "Altitude: " + str(craft_at_y)
	
	queue_redraw()


func _draw() -> void:
	var pos = Vector2(0, craft_at_y)
	var pscale = 1.0
	if is_sim:
		pscale = max_scale
	data.rocket.draw_rocket(self, pos, pscale)


func assemble_craft() -> void:
	is_sim = false
	craft_at_y = 0
	data.rocket.remove_part(GlobalInfo.RocketPartType.BurnThrusterMk1)
	queue_redraw()


func launch() -> void:
	data.rocket.add_part(GlobalInfo.RocketPartType.BurnThrusterMk1)
	is_sim = true
	craft_at_y = 200
