extends Control

@export var continue_button: Button
@export var save_button: Button


func _ready() -> void:
	update_buttons()

func update_buttons() -> void:
	var exists := Global.has_save()
	continue_button.disabled = not exists
	
func _on_button_newgame_pressed() -> void:
	Global.new_game()

func _on_button_save_pressed() -> void:
	Global.save_game()

func _on_button_continue_pressed() -> void:
	Global.load_game()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
