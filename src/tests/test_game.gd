extends GutTest

func test_flight():
	var scene: Game = load("res://game/game.tscn").instantiate()
	var data = GameData.new()
	scene.data = data
	data.rocket.add_part(GlobalInfo.RocketPartType.NoseMk1)
	data.rocket.add_part(GlobalInfo.RocketPartType.PodMk1)
	data.rocket.add_part(GlobalInfo.RocketPartType.FuelMk1)
	data.rocket.add_part(GlobalInfo.RocketPartType.ThrusterMk1)

	get_tree().get_root().add_child(scene)

	scene._on_launch_button_pressed()

	await wait_seconds(10)
	assert_true(data.flight != null and data.flight.is_active)
	scene.queue_free()
