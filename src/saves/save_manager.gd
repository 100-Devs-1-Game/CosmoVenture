class_name SaveManager extends Node

const save_path := "user://save.tres"

func save(data: GameData):
	ResourceSaver.save(data, save_path)

func load() -> GameData:
	if (ResourceLoader.exists(save_path)):
		var data = ResourceLoader.load(save_path) as GameData
		if data != null:
			return data
	return GameData.new()
