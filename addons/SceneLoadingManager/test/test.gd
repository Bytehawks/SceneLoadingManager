extends Control

@onready var button: Button = $Button
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	

func _on_button_pressed() -> void:
	if label.text == "Test1":
		SceneLoader.load_scene("uid://cjb6g3p2daxgi")
	elif label.text == "Test2":
		SceneLoader.load_scene("uid://dt6o4j30oopev")
