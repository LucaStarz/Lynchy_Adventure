extends ColorRect

@onready var world: Resource = preload("res://scenes/systems/world_system.tscn")

@onready var title: Label = $Title
@onready var start: Button = $Buttons/StartButton

func _ready() -> void:
	self.start.grab_focus()
	self.title.text = tr("title_main_menu")
	self.start.text = tr("button_start_main")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(self.world)


func _on_config_button_pressed() -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()
