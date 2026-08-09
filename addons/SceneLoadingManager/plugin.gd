@tool
extends EditorPlugin

# Replace this value with a PascalCase autoload name, as per the GDScript style guide.
const AUTOLOAD_NAME = "SceneLoader"

func _enable_plugin():
	add_autoload_singleton(AUTOLOAD_NAME, "scripts/autoloads/scene_loader.gd")

func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)
