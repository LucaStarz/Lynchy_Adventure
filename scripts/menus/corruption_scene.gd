extends ColorRect

@onready var main_menu: Resource = preload("res://scenes/menus/main_menu.tscn")

func _ready() -> void:
	$Title.text = tr("title_corrupted")
	$Informations.text = tr("infos_corrupted")
	$ReloadButton.text = tr("button_reload_corrupted")
	
	$Failure.visible = false
	$Failure.text = tr("failure_corrupted")

func _on_reload_button_pressed() -> void:
	if DataSystem.repopulate():
		get_tree().change_scene_to_packed(self.main_menu)
	else:
		$Failure.visible = true
