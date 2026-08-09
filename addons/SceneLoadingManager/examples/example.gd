extends Node

@onready var button: Button = $Button
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	# override the Loading Screen if Example 2 is loaded
	if self.name == "Example 2-1" or self.name == "Example 2-2":
		SceneLoader.set_loading_screen("uid://gi1eerdigbvp")
	if self.name == "Example 3-1" or self.name == "Example 3-2":
		SceneLoader.set_loading_screen("uid://bhs04f6ut4hcn")
	

func _on_button_pressed() -> void:
	
	if self.name == "Example 1-1":
		SceneLoader.load_scene("uid://cjb6g3p2daxgi")
	elif self.name == "Example 1-2":
		SceneLoader.load_scene("uid://dt6o4j30oopev")
	if self.name == "Example 2-1":
		SceneLoader.load_scene("uid://cpo5hfp6etcea")
	elif self.name == "Example 2-2":
		SceneLoader.load_scene("uid://drrdkwdlv4sf6")
	if self.name == "Example 3-1":
		SceneLoader.load_scene("uid://sm73fib73nj6")
	elif self.name == "Example 3-2":
		SceneLoader.load_scene("uid://bwc3fgdgx4nv6")
