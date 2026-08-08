@tool
@icon("uid://ea3pvieo8u0d")
extends CanvasLayer
class_name LoadingScreen

signal loading_screen_ready

## the panel that is used to overblend the current scene
@export var overlay_panel: Panel
## minimum time the loading screen should be displayed (in seconds)
@export var min_display_time: float = 0.0
## time for the transition (in seconds)
@export var transition_time: float = 0.5

@export var use_mask_cutout: bool = false

@export_group("Progressbar", "pbar")
@export var pbar_use_progress_bar: bool:
	set(value):
		pbar_use_progress_bar = value
		notify_property_list_changed()
@export var pbar_texture_progress_bar: TextureProgressBar

var progress_value: float = 0.0

func _ready() -> void:
	if overlay_panel == null:
		printerr("Overlay Panel not defined")
		return
	if pbar_use_progress_bar and pbar_texture_progress_bar == null:
		printerr("Progressbar activated, but no Texture-Progressbar defined")
		return
	(overlay_panel.material as ShaderMaterial).set_shader_parameter("scale", 0.0)
	await _lets_tween(overlay_panel, 1.0, use_mask_cutout)
	loading_screen_ready.emit()

func _on_progress_changed(_new_value: float) -> void:
	if pbar_use_progress_bar and pbar_texture_progress_bar != null:
		if progress_value < pbar_texture_progress_bar.max_value:
			progress_value = remap(_new_value, 0.0, 1.0, pbar_texture_progress_bar.min_value, pbar_texture_progress_bar.max_value)
			pbar_texture_progress_bar.value = progress_value

func _on_load_finished() -> void:
	await get_tree().create_timer(min_display_time).timeout
	await _lets_tween(overlay_panel, 0.0, use_mask_cutout)
	queue_free()

func _lets_tween(object: Object, target_value: float, mask_cutout: bool = false) -> void:
	var tween = create_tween().set_parallel(false)
	if pbar_use_progress_bar and pbar_texture_progress_bar != null:
		pbar_texture_progress_bar.value = 0.0
	if mask_cutout:
		tween.tween_property(object.material, "shader_parameter/scale", target_value, transition_time)
	else:
		tween.tween_property(object, "modulate:a", target_value, transition_time)
	await tween.finished
	
#region Tool Scripts
func _validate_property(property: Dictionary) -> void:
	if property.name == "pbar_texture_progress_bar" and not pbar_use_progress_bar:
		property.usage |= PROPERTY_USAGE_READ_ONLY
#endregion
