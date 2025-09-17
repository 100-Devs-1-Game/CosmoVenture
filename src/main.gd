extends Node


enum GameState {
	OPENED, ## Game is inside main menu, not yet started.
	STARTED, ## Game has been started.
	PAUSED, ## Game has been started and is paused.
}


@onready var game_state := GameState.OPENED
@onready var save_manager := SaveManager.new()
@onready var data: GameData


var game_scene = preload("res://game/game.tscn")
var game: Game


func _ready() -> void:
	_show_menu()


func _start_game() -> void:
	game = game_scene.instantiate()
	game.data = data
	%MainMenu.hide()
	game_state = GameState.STARTED
	add_child(game)


func _show_menu() -> void:
	if game_state == GameState.OPENED:
		%NewGameButton.show()
		%SaveButton.hide()
	else:
		%NewGameButton.hide()
		%SaveButton.show()
	%MainMenu.show()



###### Menu Button signal handlers


func _on_new_game_button_pressed() -> void:
	data = GameData.new()
	_start_game()


func _on_continue_button_pressed() -> void:
	if game_state == GameState.OPENED:
		data = save_manager.load()
		_start_game()
	else:
		_handle_pause_input()


func _on_save_button_pressed() -> void:
	save_manager.save(data)


func _on_settings_button_pressed() -> void:
	# TODO: Remove
	if data != null:
		data.score += 1
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()



###### Unhandled (pause) handler

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_handle_pause_input()


func _handle_pause_input() -> void:
	match game_state:
		GameState.OPENED:
			# Do nothing
			pass
		GameState.STARTED:
			get_tree().paused = true
			game_state = GameState.PAUSED
			_show_menu()
			game.hide()
		GameState.PAUSED:
			get_tree().paused = false
			game_state = GameState.STARTED
			%MainMenu.hide()
			game.show()
		_:
			print("Unhandled state " + str(game_state))
