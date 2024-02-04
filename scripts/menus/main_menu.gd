extends ColorRect

@onready var world: Resource = preload("res://scenes/systems/world_system.tscn")

@onready var title: Label = $Title
@onready var start: Button = $StartButton

func _ready() -> void:
	self.title.grab_focus()
	self.title.text = tr("title_main_menu")
	self.start.text = tr("button_start_main")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(self.world)
