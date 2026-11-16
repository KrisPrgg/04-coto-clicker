extends Control

@export var coins_label: Label
@export var anim: AnimatedSprite2D
@export var timer_coin: Timer
@export var level_ui: HBoxContainer
@export var level_ui_texture: Texture 
@export var click_sound: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ui()
	update_ui_level()
	if Global.auto_coin:
		timer_coin.start()

func _on_timer_timeout() -> void:
	Global.coins += Global.coins_per_click
	update_ui()
	show_floating_text()

func update_ui() -> void:
	coins_label.text = str(Global.coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_ui()

func update_ui_level() -> void:
	for i in range(Global.coins_per_click / 2):
		var slot = TextureRect.new()
		slot.texture = level_ui_texture
		slot.stretch_mode = TextureRect.STRETCH_KEEP
		level_ui.add_child(slot)

func _on_cat_animated_sprite_2d_animation_finished() -> void:
	anim.play('idle')
	
func _on_click_button_pressed() -> void:
	Global.add_coins(Global.coins_per_click)
	anim.play('happy')
	click_sound.pitch_scale = randf_range(0.9, 1.1)
	click_sound.play()
	update_ui() # Replace with function body.
	show_floating_text()

const FLOAT_TEXT_SCENE: PackedScene = preload("res://scenes/float_text.tscn")

func show_floating_text() -> void:
	var text_instance = FLOAT_TEXT_SCENE.instantiate()
	text_instance.text = '+' + str(Global.coins_per_click)
	add_child(text_instance)
	var random_x = randi_range(20, 100)
	var random_y = randi_range(80, 150)
	text_instance.position = Vector2(random_x, random_y)


func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/shop.tscn')
	

func _on_pause_button_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/menu.tscn')
