class_name Game extends Control

@export var data: GameData

func _ready() -> void:
	print("Game ready")
	print("Score: " + str(data.score))
	%Label.text = "Game score: " + str(data.score)

func _process(delta: float) -> void:
	%Label.text = "Game score: " + str(data.score)
