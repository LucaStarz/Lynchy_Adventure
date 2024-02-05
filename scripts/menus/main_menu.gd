extends ColorRect

@onready var world: Resource = preload("res://scenes/systems/world_system.tscn")

func _ready() -> void:
	$Buttons/StartButton.grab_focus()
	
	$Title.text = tr("title_main_menu")
	$Buttons/StartButton.text = tr("button_start_main")
	$Buttons/ConfigButton.text = tr("button_config_main")
	$Buttons/QuitButton.text = tr("button_quit_main")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(self.world)


func _on_config_button_pressed() -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()
